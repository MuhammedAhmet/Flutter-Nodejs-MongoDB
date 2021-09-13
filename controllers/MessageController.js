const express = require("express");
var router = express.Router();

var ObjectID = require("mongoose").Types.ObjectId;

var {Message} = require("../models/message");

router.get("/",(req,res)=>{
    Message.find((err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while retrieving all records : "+JSON.stringify(err,undefined,2));
        }
    })
})

router.post("/",(req,res)=>{
    if(req.body.username == "")
    {
        throw (new Error('Hata oluştu'));   
    }
    else{
        var newRecord = new Message({
            message : req.body.message,
            date : req.body.date,
            destination : req.body.destination
        })
        newRecord.save((err,docs)=>{
            if(!err){
                res.send(docs)
            }
            else{
                console.log("ERROR while creating new record : "+JSON.stringify(err,undefined,2));
            }
        })
    }
})

router.put("/:id",(req,res)=>{

    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    
    var updatedRecord = {
        message : req.body.message,
        date : req.body.date,
        destination : req.body.destination
    }
    
    Message.findByIdAndUpdate(req.params.id,{$set : updatedRecord},{new:true},(err,docs)=>{   //new : true   --> postman de istek attığımızda sonucu yazdırsın diye yazdım
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while updating a record : "+JSON.stringify(err,undefined,2));
        } 
    })
})

router.delete("/:id",(req,res)=>{  //sil
    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }

    Message.findByIdAndDelete(req.params.id,(err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while deleting a record : "+JSON.stringify(err,undefined,2));
        }
    })   
})

module.exports = router;