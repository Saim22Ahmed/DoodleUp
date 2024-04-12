import mongoose from "mongoose";

export const connectDB = () =>
  mongoose
    .connect(process.env.MONGO_URL, { dbName: "doodleup" })
    .then((c) => {
      console.log(`database connected with ${c.connection.host}`);
    })
    .catch((err) => {
      console.log(err);
    });
