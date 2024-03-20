const express = require("express");
const mongoose = require("mongoose");
const app = express();
const Requesterdetails = require("./requesterdetails");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


mongoose.connect("mongodb+srv://tharunrachabanti:tharun@cluster0.gxmq3cs.mongodb.net/bloodconect_db&appName=Cluster0")
  .then(() => {
    console.log('Connected to MongoDB');
    app.post("/api/add_requesterdata", async (req, res) => {
      console.log("Result", req.body);

      let data = Requesterdetails(req.body);

      try {
        let dataToStore = await data.save();
        res.status(200).json(dataToStore);
      } catch (error) {
        res.status(400).json({
          'status': error.message
        });
      }
    });

    // get requested details 
    app.get("/api/get_requesteddetails/", async (req,res)=>{
        try {
            let data = await Requesterdetails.find();
            res.status(200).json(data);
            
        } catch (error) {
            res.status(500).json(error.message)
            
        }


        // if(productData.length>0){
        //     res.status(200).send({
        //         'status_code' : 200,
        //         'products': productData
        //     });
    
        // }else{
        //     res.status(200).send({
        //         'status_code' : 200,
        //         'products': []
        //     });
    
    
        // }
    
    })




  })
  .catch((error) => {
    console.error('Error connecting to MongoDB', error);
  });



// Connect to MongoDB
// mongoose.connect("mongodb+srv://tharunrachabanti:tharun@cluster0.gxmq3cs.mongodb.net/bloodconect_db&appName=Cluster0",(error)=> {
//     if(!error){
//         console.log('Connected to MongoDB');
//         app.post("/api/add_requesterdata", async (req,res)=>{
//             console.log("Result", req.body);

//             let data = Requesterdetails(req.body);

//             try {
//                 let dataToStore =await data.save();
//                 res.status(200).json(dataToStore);
                
//             } catch (error) {

//                 res.status(400).json({
//                     'status': error.message
//                 })
//             }
        
//             // const rdata ={
//             //     "id": requestersdata.length + 1,
//             //     "rname": req.body.rname,
//             //     "rbloodgroup": req.body.rbloodgroup,
//             //     "rgender": req.body.rgender,
//             //     "raddress": req.body.raddress,
//             //     "rphonenumber": req.body.rphonenumber,
//             //     "rtag": req.body.rtag,
//             // };
//             // requestersdata.push(rdata);
//             // console.log("Final", rdata);
        
//             // res.status(200).send({
//             //     "status_code": 200,
//             //     "message": "requester data added successfully",
//             //     "requesterdata": rdata
//             // });
//         });
//     }
//     else{
//         console.error('Error connecting to MongoDB');
//     }
// })

const requestersdata = [];



app.listen(3000, ()=>{
    console.log("connected to server at 3000");
});
