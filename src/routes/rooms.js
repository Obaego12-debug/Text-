const express = require('express');
const roomController = require('../controllers/roomController');
const { authenticate } = require('../middleware/auth');

const router = express.Router();

router.post('/', authenticate, roomController.createRoom);
router.get('/', roomController.getRooms);
router.get('/:id', roomController.getRoomById);
router.post('/:id/join', authenticate, roomController.joinRoom);
router.post('/:id/leave', authenticate, roomController.leaveRoom);

module.exports = router;