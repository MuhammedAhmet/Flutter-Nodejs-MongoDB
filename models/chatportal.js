const mongoose = require("mongoose");
require('mongoose-type-email');


var ChatPortal = mongoose.model("ChatPortals",{
    user1 : {
        type:mongoose.Schema.Types.ObjectId,
        ref:"User"
    },
    user2 : {
        type:mongoose.Schema.Types.ObjectId,
        ref:"User"
    }
},"ChatPortals")

module.exports = { ChatPortal }