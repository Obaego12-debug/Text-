const User = require('../models/User');
const jwt = require('jsonwebtoken');
const config = require('../config');
const logger = require('../utils/logger');

const generateToken = (userId) => {
  return jwt.sign({ id: userId }, config.jwtSecret, {
    expiresIn: config.jwtExpire
  });
};

const register = async (req, res) => {
  try {
    const { username, email, password, language } = req.body;

    // Validate input
    if (!username || !email || !password) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Check if user exists
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      return res.status(409).json({ error: 'User already exists' });
    }

    // Create new user
    const user = new User({
      username,
      email,
      password,
      language: language || 'en'
    });

    await user.save();
    logger.info(`New user registered: ${email}`);

    const token = generateToken(user._id);

    res.status(201).json({
      message: 'Registration successful',
      user: user.toJSON(),
      token
    });
  } catch (error) {
    logger.error(`Registration error: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    const user = await User.findOne({ email }).select('+password');
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const isPasswordValid = await user.matchPassword(password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    user.lastLogin = new Date();
    await user.save();

    const token = generateToken(user._id);
    logger.info(`User logged in: ${email}`);

    res.json({
      message: 'Login successful',
      user: user.toJSON(),
      token
    });
  } catch (error) {
    logger.error(`Login error: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const getCurrentUser = async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(user.toJSON());
  } catch (error) {
    logger.error(`Get user error: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

const updateProfile = async (req, res) => {
  try {
    const { bio, language, timezone, avatar } = req.body;

    const user = await User.findByIdAndUpdate(
      req.user.id,
      {
        bio,
        language: language || user.language,
        timezone: timezone || user.timezone,
        avatar
      },
      { new: true, runValidators: true }
    );

    logger.info(`User profile updated: ${user.email}`);
    res.json(user.toJSON());
  } catch (error) {
    logger.error(`Update profile error: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

module.exports = { register, login, getCurrentUser, updateProfile, generateToken };
