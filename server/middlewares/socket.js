import { Server } from "socket.io";
import { app } from "../app.js";
import http from "http";

import { createRoom, joinRoom } from "../controllers/room.js";

export const SocketSetup = () => {
  const server = http.createServer(app);
  const io = new Server(server);

  io.on("connection", (socket) => {
    console.log("A user connected");
    // Create Room
    socket.on("create-room", (roomData) => createRoom(io, socket, roomData));

    // Join Room
    socket.on("join-room", (roomData) => joinRoom(io, socket, roomData));
  });

  server.listen(process.env.PORT || 3000, "0.0.0.0", () => {
    console.log(`Web socket Server started on port ${process.env.PORT}`);
  });
};
