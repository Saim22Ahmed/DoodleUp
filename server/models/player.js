import mongoose from "mongoose";

export const PlayerSchema = new mongoose.Schema({
  userName: {
    type: String,
    required: true,
  },
  socketID: {
    type: String,
  },
  isPartyLeader: {
    type: Boolean,
    default: false,
  },
  points: {
    type: Number,
    default: 0,
  },
});

export const Player = mongoose.model("Player", PlayerSchema);
