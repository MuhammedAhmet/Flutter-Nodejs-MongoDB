const express = require("express");
var router = express.Router();

var ObjectID = require("mongoose").Types.ObjectId;

var {Activity} = require("../models/activity");

router.get("/",(req,res)=>{
    Activity.find((err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while retrieving all records : "+JSON.stringify(err,undefined,2));
        }
    })
})

////// GET ACT  ////////
router.get("/:id",(req,res) =>{
    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    Activity.findById(req.params.id,(err,docs) => {
        if(err){
            res.json(err)
        }
        else{
            res.json(docs)
        }
    })
})
////////////////////////////////////

router.post("/",(req,res)=>{
    if(req.body.username == "")
    {
        throw (new Error('Hata oluştu'));   
    }
    else{
        var newRecord = new Activity({
            name : req.body.name,
            information : req.body.information,
            place : req.body.place,
            date : req.body.date,
            hour : req.body.hour,
            creatorUsername : req.body.creatorUsername,
            attendees : req.body.attendees
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

/*router.put("/:id",(req,res)=>{

    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    
    var updatedRecord = {
        name : req.body.name,
        information : req.body.information,
        place : req.body.place,
        date : req.body.date,
        hour : req.body.hour,
        creatorUsername : req.body.creatorUsername,
        attendees : req.body.attendees
    }
    
    Activity.findByIdAndUpdate(req.params.id,{$set : updatedRecord},{new:true},(err,docs)=>{   //new : true   --> postman de istek attığımızda sonucu yazdırsın diye yazdım
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while updating a record : "+JSON.stringify(err,undefined,2));
        } 
    })
})*/

///// ADD ATTENDEESS ////////
router.put("/:id",(req,res)=>{

    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    
    Activity.findByIdAndUpdate(req.params.id,{$push : {attendees : req.body.attendees}},{new:true},(err,docs)=>{   //new : true   --> postman de istek attığımızda sonucu yazdırsın diye yazdım
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while updating a record : "+JSON.stringify(err,undefined,2));
        } 
    })
})
//////////////////////////////

router.delete("/:id",(req,res)=>{  //sil
    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }

    Activity.findByIdAndDelete(req.params.id,(err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while deleting a record : "+JSON.stringify(err,undefined,2));
        }
    })   
})

module.exports = router;