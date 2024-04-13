import { Server } from "socket.io";
import { app } from "../app.js";
import http from "http";
import { Room } from "../models/Room.js";
import { getWord } from "../api/word.js";

export const SocketSetup = () => {
  const server = http.createServer(app);
  const io = new Server(server);

  io.on("connection", (socket) => {
    console.log("A user connected");
    // Add your WebSocket server logic here
    socket.on(
      "create-room",
      async ({ userName, roomName, maxSize, maxRound }) => {
        try {
          const roomAlreadyExist = await Room.findOne({ roomName });
          if (roomAlreadyExist) {
            socket.emit("Room with this name already exist");
            return;
          }
          // room
          let room = new Room();
          const word = getWord();
          room.word = word;
          room.roomName = roomName;
          room.maxSize = maxSize;
          room.maxRound = maxRound;
          // player
          let player = {
            userName,
            socketID: socket.id,
            isPartyLeader: true,
          };
          // pusing player in the room
          room.players.push(player);
          await room.save();
          socket.join(room);
          io.to(roomName).emit("updateRoom", room);
        } catch (err) {
          console.log(err);
        }
      }
    );
  });

  server.listen(process.env.PORT || 3000, "0.0.0.0", () => {
    console.log(`Web socket Server started on port ${process.env.PORT}`);
  });
};
