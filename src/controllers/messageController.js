const Message = require('../models/Message');
const Room = require('../models/Room');
const logger = require('../utils/logger');

const saveMessage = async (roomId, userId, username, content) => {
  try {
    const message = new Message({
      roomId,
      userId,
      username,
      content
    });

    await message.save();

    // Update room's message count and last activity
    await Room.findByIdAndUpdate(roomId, {
      messageCount: (await Message.countDocuments({ roomId })),
      lastActivity: new Date()
    });

    logger.info(`Message saved in room ${roomId}`);
    return message;
  } catch (error) {
    logger.error(`Error saving message: ${error.message}`);
    throw error;
  }
};

const getMessageHistory = async (roomId, limit = 50, skip = 0) => {
  try {
    const messages = await Message.find({ roomId, deletedAt: null })
      .sort({ createdAt: -1 })
      .limit(limit)
      .skip(skip)
      .populate('userId', 'username avatar');

    return messages.reverse();
  } catch (error) {
    logger.error(`Error fetching messages: ${error.message}`);
    throw error;
  }
};

const deleteMessage = async (messageId, userId) => {
  try {
    const message = await Message.findById(messageId);

    if (!message) {
      throw new Error('Message not found');
    }

    if (message.userId.toString() !== userId) {
      throw new Error('Unauthorized');
    }

    message.deletedAt = new Date();
    await message.save();

    logger.info(`Message deleted: ${messageId}`);
    return message;
  } catch (error) {
    logger.error(`Error deleting message: ${error.message}`);
    throw error;
  }
};

const editMessage = async (messageId, userId, newContent) => {
  try {
    const message = await Message.findById(messageId);

    if (!message) {
      throw new Error('Message not found');
    }

    if (message.userId.toString() !== userId) {
      throw new Error('Unauthorized');
    }

    message.content = newContent;
    message.editedAt = new Date();
    await message.save();

    logger.info(`Message edited: ${messageId}`);
    return message;
  } catch (error) {
    logger.error(`Error editing message: ${error.message}`);
    throw error;
  }
};

module.exports = { saveMessage, getMessageHistory, deleteMessage, editMessage };