import { Server } from "socket.io";
import { app } from "../app.js";
import http from "http";

export const SocketSetup = () => {
  const server = http.createServer(app);
  const io = new Server(server);

  io.on("connection", (socket) => {
    console.log("A user connected");
    // Add your WebSocket server logic here
  });

  server.listen(process.env.PORT || 3000, "0.0.0.0", () => {
    console.log(`Web socket Server started on port ${process.env.PORT}`);
  });
};
