const mongoose = require("mongoose");

var User = mongoose.model("Users",{
    name : {type:String, default:"Null"},
    surname : {type:String, default:"Null"},
    email : {type:String,default:"Null"},
    username : {type:String,default:"Null"},
    password : {type:String,default:"Null"},
    gender : {type:String,default:"Null"},
    age : {type:String,default:"Null"},
    description : {type:String,default:"Null"},  //about
    imageURL : {type:String,default:"https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"},
},"Users")

module.exports = { User }