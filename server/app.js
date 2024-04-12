import express from "express";
import { config } from "dotenv";
import { SocketSetup } from "./middlewares/socket.js";

export const app = express();

config({
  path: "./data/config.env",
});

// websocket server

SocketSetup();

// middlwares
app.use(express.json());
// routes

// error
