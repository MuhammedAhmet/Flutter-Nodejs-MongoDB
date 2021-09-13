const mongoose = require("mongoose");
require('mongoose-type-email');


var Message = mongoose.model("Messages",{
    message : {type:String},
    date : {type:String},
    destination : [{
        type:mongoose.Schema.Types.ObjectId,
        ref:"User"
    }
    ]
},"Messages")

module.exports = { Message }