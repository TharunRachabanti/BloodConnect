const express = require("express");
const mongoose = require("mongoose");

const app = express();
const RequesterDetails = require("./requesterdetails");
const MessageImage = require("./messagesimages");
const DonateMeassageImage = require("./donatemessageimages")

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

mongoose.connect("mongodb+srv://tharunrachabanti:tharun@cluster0.gxmq3cs.mongodb.net/bloodconect_db&appName=Cluster0")
  .then(() => {
    console.log('Connected to MongoDB');

    // Endpoint to add requester data
    app.post("/api/add_requesterdata", async (req, res) => {
      console.log("Request Body:", req.body);
  
      try {
          const { rname, rbloodgroup, rgender, raddress, rphonenumber, rtag, showInProfile, username } = req.body;
  
          // Ensure showInProfile is properly handled as a boolean
          const isShowInProfile = showInProfile === 'true' || showInProfile === true;
  
          // Save the request data to the database with timestamp
          const newData = new RequesterDetails({ 
              rname, 
              rbloodgroup, 
              rgender, 
              raddress, 
              rphonenumber, 
              rtag, 
              showInProfile: isShowInProfile,
              username, // Include the username in the database entry
              createdAt: new Date() // Current timestamp
          });
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

    // Endpoint to store message, image ID, and timestamp in MongoDB
    app.post("/api/store_image_message", async (req, res) => {
      console.log("Message, image, and username:", req.body);
      try {
        const { imageUrl, message, username } = req.body; // Extract fields from request body

        // Save the message, image URL, username, and timestamp to the database
        const newData = new MessageImage({ imageUrl, message, username });
        const savedData = await newData.save();

        res.status(200).json(savedData);
      } catch (error) {
        res.status(400).json({ status: error.message });
      }
    });

app.post("/api/store_donate_image_message", async (req, res) => {
  console.log("Message and image:", req.body);
  try {
    const { imageUrl, message, username } = req.body; // Ensure correct field names

    // Save the message, image URL, current user's name, and timestamp to the database
    const newData = new DonateMeassageImage({ imageUrl, message, username });
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


    app.get("/api/get_Donate_image_message", async (req, res) => {
      try {

        // Fetch all data from the database
        const data = await DonateMeassageImage.find();
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
