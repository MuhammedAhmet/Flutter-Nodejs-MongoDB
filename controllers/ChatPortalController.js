const express = require("express");
var router = express.Router();

var ObjectID = require("mongoose").Types.ObjectId;

var {ChatPortal} = require("../models/chatportal");

router.get("/",(req,res)=>{
    ChatPortal.find((err,docs)=>{
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
        var newRecord = new ChatPortal({
            user1 : req.body.user1,
            user2 : req.body.user2
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
        user1 : req.body.user1,
        user2 : req.body.user2
    }
    
    ChatPortal.findByIdAndUpdate(req.params.id,{$set : updatedRecord},{new:true},(err,docs)=>{   //new : true   --> postman de istek attığımızda sonucu yazdırsın diye yazdım
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

    ChatPortal.findByIdAndDelete(req.params.id,(err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while deleting a record : "+JSON.stringify(err,undefined,2));
        }
    })   
})

module.exports = router;