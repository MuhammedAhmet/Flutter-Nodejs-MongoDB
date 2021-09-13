const mongoose = require("mongoose");
require('mongoose-type-email');


var Activity = mongoose.model("Activities",{
    name : {type:String},
    information : {type:String},
    place : {type:String},
    date : {type:String},
    hour : {type:String},
    creatorUsername : {type:String},
    attendees : {type:[String]}
},"Activities")

module.exports = { Activity }