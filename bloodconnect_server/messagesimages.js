const mongoose = require("mongoose");

let messageImageSchema = new mongoose.Schema({
  imageUrl: {
    required: true,
    type: String
  },
  message: {
    required: true,
    type: String
  }
});

module.exports = mongoose.model("messageimages", messageImageSchema);
