import express from "express";
import { config } from "dotenv";
import { SocketSetup } from "./middlewares/socket.js";
import { connectDB } from "./data/database.js";

export const app = express();

config({
  path: "./data/config.env",
});

// websocket server
SocketSetup();

// connect DB
connectDB();

// middlwares
app.use(express.json());
// routes

// error
