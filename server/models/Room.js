import mongoose from "mongoose";
import { PlayerSchema } from "./player.js";

const Schema = new mongoose.Schema({
  word: {
    type: String,
    required: true,
  },
  roomName: {
    type: String,
    required: true,
    unique: true,
    trim: true,
  },
  maxSize: {
    type: Number,
    required: true,
    default: 2,
  },
  maxRound: {
    type: Number,
    required: true,
    default: 5,
  },
  currentRound: {
    type: Number,
    required: true,
    default: 1,
  },
  players: [PlayerSchema],
  isJoin: {
    type: Boolean,
    default: true,
  },
  turn: PlayerSchema,

  turnIndex: {
    type: Number,
    default: 0,
  },
});

export const Room = mongoose.model("Room", Schema);
