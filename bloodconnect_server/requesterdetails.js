const mongoose = require("mongoose");

let dataSchema = new mongoose.Schema({
    'rname': {
        required: true,
        type: String
    },
    'rbloodgroup': {
        required: true,
        type: String
    },
    'rgender': {
        required: true,
        type: String
    },
    'raddress': {
        required: true,
        type: String
    },
    'rphonenumber': {
        required: true,
        type: String
    },
    'rtag': {
        required: true,
        type: String
    },

});

module.exports = mongoose.model("requestersdetails", dataSchema);