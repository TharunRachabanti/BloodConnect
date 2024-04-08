const mongoose = require("mongoose");

let dataSchema = new mongoose.Schema({
    imageUrl: {
        required: true,
        type: String
    },
    message: {
        required: true,
        type: String
    }
});

module.exports = mongoose.model("messageimages", dataSchema); // Use a meaningful collection name
