const mongoose = require("mongoose");
mongoose.set('useFindAndModify', false);  /// edit ve delete warning i almamak için bu kodu yazın

mongoose.connect("mongodb+srv://dbUser:Apocalypsei1@clusterfirst.xo5ug.mongodb.net/MyDb?retryWrites=true&w=majority",{useUnifiedTopology: true,useNewUrlParser: true},
err => {
    if(!err)
    console.log("MongoDB successfully connected");
    else
    console.log("Problem occured while connecting to MongoDB : " + JSON.stringify(err,undefined,2));
});