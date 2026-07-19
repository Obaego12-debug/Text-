# Text Chat App

A modern, real-time chat application built with Node.js, Express, and Socket.io. Users can create rooms, chat in real-time, and see typing indicators.

## Features

- ✨ Real-time messaging with WebSocket
- 👥 Multiple chat rooms
- 📝 Live typing indicators
- 👤 User presence tracking
- 📱 Responsive design
- 🎨 Modern UI with gradient design
- 🔒 XSS protection

## Getting Started

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Obaego12-debug/Text-.git
cd Text-
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file:
```bash
cp .env.example .env
```

4. Configure `.env` if needed (default settings work for local development)

### Running the App

**Development mode** (with auto-reload):
```bash
npm run dev
```

**Production mode**:
```bash
npm start
```

The app will start on `http://localhost:3000` by default.

### Testing the Chat

1. Open `http://localhost:3000` in your browser
2. Enter a username
3. Enter a room ID (e.g., "general", "tech", "random")
4. Click "Join Room"
5. Open another browser tab/window and repeat steps 2-4 with the same room ID
6. Start chatting!

## Project Structure

```
src/
  ├── server.js          Main application with Socket.io setup
public/
  ├── index.html         Chat UI
  ├── styles.css         CSS styling
  ├── chat.js            Client-side Socket.io logic
.env.example             Environment variables template
.gitignore              Git ignore rules
.eslintrc.json          ESLint configuration
package.json            Project configuration
README.md               This file
```

## API Endpoints

### REST API
- `GET /api/health` — Server health check
- `GET /api/rooms` — List all active chat rooms
- `GET /api/users` — List all connected users

### Socket.io Events

**Client → Server:**
- `join_room` — Join a chat room with username
- `send_message` — Send a message to the room
- `typing` — Notify that user is typing
- `leave_room` — Leave current room

**Server → Client:**
- `user_joined` — User joined the room
- `receive_message` — New message received
- `user_typing` — User is typing indicator
- `user_left` — User left the room
- `user_disconnected` — User disconnected

## Development

### Linting
```bash
npm run lint
```

### Testing
```bash
npm test
```

## Environment Variables

```env
PORT=3000              # Server port
NODE_ENV=development   # Node environment
```

## Technologies Used

- **Express.js** — Web framework
- **Socket.io** — Real-time WebSocket communication
- **dotenv** — Environment configuration
- **nodemon** — Development auto-reload
- **ESLint** — Code linting
- **Jest** — Testing framework

## Future Enhancements

- [ ] User authentication with JWT
- [ ] Message persistence (MongoDB/PostgreSQL)
- [ ] Private direct messages
- [ ] User profiles and avatars
- [ ] Message reactions and editing
- [ ] File sharing
- [ ] Message search
- [ ] Voice/video chat

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License

## Support

For issues and questions, please create an issue on GitHub.
