const express = require("express");
const mongoose = require("mongoose");

const app = express();
const RequesterDetails = require("./requesterdetails");
const MessageImage = require("./messagesimages");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

mongoose.connect("mongodb+srv://tharunrachabanti:tharun@cluster0.gxmq3cs.mongodb.net/bloodconect_db&appName=Cluster0")
  .then(() => {
    console.log('Connected to MongoDB');

    // Endpoint to add requester data
    app.post("/api/add_requesterdata", async (req, res) => {
      console.log("Request Body:", req.body);

      try {
        const { rname, rbloodgroup, rgender, raddress, rphonenumber, rtag, showInProfile } = req.body;

        // Ensure showInProfile is properly handled as a boolean
        const isShowInProfile = showInProfile === 'true' || showInProfile === true;

        // Save the request data to the database
        const newData = new RequesterDetails({ rname, rbloodgroup, rgender, raddress, rphonenumber, rtag, showInProfile: isShowInProfile });
        const savedData = await newData.save();

        res.status(200).json(savedData);
      } catch (error) {
        res.status(400).json({ status: error.message });
      }
    });

    // Endpoint to get requested details
    app.get("/api/get_requesteddetails", async (req, res) => {
      try {
        // Fetch all data from the database
        const data = await RequesterDetails.find();
        res.status(200).json(data);
        
        console.log("Fetched Data:", data);
      } catch (error) {
        res.status(500).json({ status: error.message });
      }
    });

    // Endpoint to store message and image ID in MongoDB
    app.post("/api/store_image_message", async (req, res) => {
      console.log("Message and image :", req.body);
      try {
        const { imageUrl, message } = req.body; // Ensure correct field names
    
        // Save the message and image ID to the database
        const newData = new MessageImage({ imageUrl, message });
        const savedData = await newData.save();
    
        res.status(200).json(savedData);
      } catch (error) {
        res.status(400).json({ status: error.message });
      }
    });
    
    // Endpoint to retrieve image ID and message from MongoDB
    app.get("/api/get_image_message", async (req, res) => {
      try {

        // Fetch all data from the database
        const data = await MessageImage.find();
        res.status(200).json(data);
        
        console.log("Fetched Data:", data);
      } catch (error) {
        res.status(500).json({ status: error.message });
      }
    });

    app.listen(3000, () => {
      console.log("Connected to server at port 3000");
    });
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB', error);
  });
