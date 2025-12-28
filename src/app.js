require("dotenv").config();

const express = require("express");
const app = express();

app.get("/health", (req, res) => {
  res.status(200).json({
    ok: true,
    service: "iot-network-health",
    ts: new Date().toISOString(),
  });
});

const port = Number(process.env.PORT || 8081);

app.listen(port, "0.0.0.0", () => {
  console.log(`IoT Health server listening on port ${port}`);
});
