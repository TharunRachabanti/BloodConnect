const express = require("express");
const mongoose = require("mongoose");

const app = express();
const Requesterdetails = require("./requesterdetails");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

mongoose.connect("mongodb+srv://tharunrachabanti:tharun@cluster0.gxmq3cs.mongodb.net/bloodconect_db&appName=Cluster0", { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log('Connected to MongoDB');

    app.post("/api/add_requesterdata", async (req, res) => {
      console.log("Request Body:", req.body);

      try {
        const newData = new Requesterdetails(req.body);
        const savedData = await newData.save();
        res.status(200).json(savedData);
      } catch (error) {
        res.status(400).json({ status: error.message });
      }
    });

    app.get("/api/get_requesteddetails", async (req, res) => {
      try {
        const data = await Requesterdetails.find();
        res.status(200).json(data);
        console.log("Fetched Data:", data);
        // Send data directly without wrapping it in any object
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
