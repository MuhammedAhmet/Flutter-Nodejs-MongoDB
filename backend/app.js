require("./db");
const express = require("express");
const app = express();

const bodyParser = require("body-parser");
app.use(bodyParser.json());


//////////////////////////////////////////////
var userRoutes = require("./controllers/UserController");
var activityRoutes = require("./controllers/ActivityController");
var messageRoutes = require("./controllers/MessageController");
var chatportalRoutes = require("./controllers/ChatPortalController");
//////////////////////////////////////////////

const Port = process.env.Port || 4000;
app.listen(Port,() => console.log("Server started!!.. port:4000"));

//////////////////////////////////////////////
app.use("/usr",userRoutes);
app.use("/act",activityRoutes);
app.use("/msg",messageRoutes);
app.use("/chtprt",chatportalRoutes);
//////////////////////////////////////////////


app.get("/",(req,res)=>{
    res.send("Hello World");
})