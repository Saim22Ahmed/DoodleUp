import { Room } from "../models/Room.js";
import { getWord } from "../api/word.js";

export const createRoom = async (
  io,
  socket,
  { userName, roomName, maxSize, maxRound }
) => {
  try {
    const roomAlreadyExist = await Room.findOne({ roomName });
    if (roomAlreadyExist) {
      socket.emit("notCorrectGame", "Room with this name already exist");
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
    room = await room.save();
    socket.join(roomName);
    io.to(roomName).emit("updateRoom", room);
  } catch (err) {
    console.log(err);
  }
};

export const joinRoom = async (io, socket, { userName, roomName }) => {
  try {
    let room = await Room.findOne({ roomName });
    if (!room) {
      socket.emit("notCorrectGame", "Please Enter Valid Room Name");
      return;
    }
    // if room is joinable

    if (room.isJoin) {
      let player = {
        userName,
        socketID: socket.id,
      };

      room.players.push(player);

      socket.join(roomName);

      if (room.players.length === room.maxSize) {
        room.isJoin = false;
      }
      room.turn = room.players[room.turnIndex];
      room = await room.save();
    }

    // if room is filled and game has been started
    else {
      socket.emit("notCorrectGame", "Game has been started");
    }
  } catch (err) {
    console.log(err);
  }
};
