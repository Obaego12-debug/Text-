const Room = require('../models/Room');
const Message = require('../models/Message');
const logger = require('../utils/logger');

const createRoom = async (req, res) => {
  try {
    const { name, description, isPrivate, password, language } = req.body;

    if (!name) {
      return res.status(400).json({ error: 'Room name is required' });
    }

    const room = new Room({
      name,
      description,
      isPrivate,
      password,
      language: language || 'multi',
      owner: req.user.id,
      members: [req.user.id]
    });

    await room.save();
    logger.info(`Room created: ${room._id}`);

    res.status(201).json(room);
  } catch (error) {
    logger.error(`Error creating room: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const getRooms = async (req, res) => {
  try {
    const { page = 1, limit = 20, search } = req.query;
    const skip = (page - 1) * limit;

    let query = { isPrivate: false };
    if (search) {
      query.$text = { $search: search };
    }

    const rooms = await Room.find(query)
      .limit(limit)
      .skip(skip)
      .sort({ lastActivity: -1 });

    const total = await Room.countDocuments(query);

    res.json({
      rooms,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    logger.error(`Error fetching rooms: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const getRoomById = async (req, res) => {
  try {
    const room = await Room.findById(req.params.id).populate('owner', 'username avatar');

    if (!room) {
      return res.status(404).json({ error: 'Room not found' });
    }

    const messageCount = await Message.countDocuments({ roomId: room._id });

    res.json({ ...room.toObject(), messageCount });
  } catch (error) {
    logger.error(`Error fetching room: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const joinRoom = async (req, res) => {
  try {
    const room = await Room.findById(req.params.id);

    if (!room) {
      return res.status(404).json({ error: 'Room not found' });
    }

    if (room.isPrivate && !room.members.includes(req.user.id)) {
      return res.status(403).json({ error: 'This is a private room' });
    }

    if (!room.members.includes(req.user.id)) {
      room.members.push(req.user.id);
      await room.save();
      logger.info(`User ${req.user.id} joined room ${room._id}`);
    }

    res.json({ message: 'Joined room successfully', room });
  } catch (error) {
    logger.error(`Error joining room: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const leaveRoom = async (req, res) => {
  try {
    const room = await Room.findById(req.params.id);

    if (!room) {
      return res.status(404).json({ error: 'Room not found' });
    }

    room.members = room.members.filter(member => member.toString() !== req.user.id);
    await room.save();

    logger.info(`User ${req.user.id} left room ${room._id}`);
    res.json({ message: 'Left room successfully' });
  } catch (error) {
    logger.error(`Error leaving room: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

module.exports = { createRoom, getRooms, getRoomById, joinRoom, leaveRoom };