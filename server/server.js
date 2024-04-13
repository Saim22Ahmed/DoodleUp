import { app } from "./app.js";

app.get("/saim", (req, res) => {
  res.send("Hello World!");
});

// app.listen(process.env.PORT || 3000, "0.0.0.0", () => {
//   console.log(`Server started on port ${process.env.PORT}`);
// });
