const express = require("express");
var router = express.Router();

var ObjectID = require("mongoose").Types.ObjectId;

var {User} = require("../models/user");

router.get("/",(req,res)=>{
    User.find((err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while retrieving all records : "+JSON.stringify(err,undefined,2));
        }
    })
})


router.get("/username/:username",(req,res)=>{
    User.findOne({username : req.params.username},(err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while retrieving all records : "+JSON.stringify(err,undefined,2));
        }
    })
})

router.get("/:id",(req,res) =>{
    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    User.findById(req.params.id,(err,docs) => {
        if(err){
            res.json(err)
        }
        else{
            res.json(docs)
        }
    })
})

router.post("/signup",(req,res)=>{
    User.findOne({email:req.body.email},(err,docs)=>{
        if(err){
            console.log(err)
            res.json(err)
        }
        else{
            if(docs==null){
               User.findOne({username:req.body.username},(err,docs2)=>{
                   if(err){
                       console.log(err)
                       res.json(err)
                   }
                   else{
                       if(docs2==null){
                        var newRecord = new User({
                            name : req.body.name,
                            surname : req.body.surname,
                            email : req.body.email,
                            username : req.body.username,
                            password : req.body.password,
                            gender : req.body.gender,
                            age : req.body.age,
                            description : req.body.description,
                            imageURL : req.body.imageURL
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
                        else{
                            res.json({
                                message:"username already taken"
                            })
                        }
                    }
               })
            }
            else{
                res.json({
                    message:"email already taken"
                })
            }
        }
    })
})

router.post("/signin",(req,res)=>{
    User.findOne({email:req.body.email,password:req.body.password},(err,docs)=>{
        if(err){
            console.log(err)
            res.json(err)
        }
        else{
            res.json(docs)
        }
    })
})

router.put("/:id",(req,res)=>{

    if(!ObjectID.isValid(req.params.id)){
        return res.status(400).send("No record with given id : " + req.params.id)    
    }
    
    var updatedRecord = {
        name : req.body.name,
        surname : req.body.surname,
        email : req.body.email,
        username : req.body.username,
        password : req.body.password,
        gender : req.body.gender,
        age : req.body.age,
        description : req.body.description,
        imageURL : req.body.imageURL
    }
    
    User.findByIdAndUpdate(req.params.id,{$set : updatedRecord},{new:true},(err,docs)=>{   //new : true   --> postman de istek attığımızda sonucu yazdırsın diye yazdım
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
    User.findByIdAndDelete(req.params.id,(err,docs)=>{
        if(!err){
            res.send(docs);
        }
        else{
            console.log("ERROR while deleting a record : "+JSON.stringify(err,undefined,2));
        }
    })   
})

module.exports = router;