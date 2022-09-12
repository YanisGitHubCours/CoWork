const { Mongoose } = require("mongoose")
const RentModel = require("../../model/rent.js")

const createRent = async(body, res) => {
    if(!body.fk_user || !body.fk_pls || !body.fk_place){
        res.status(400).send("all input are required")
    }else{
        const rent = new RentModel(body)
        const rentExist = await RentModel.find({fk_pls: body.fk_pls, fk_place: body.fk_place, fk_user: body.fk_user})
        if(rentExist){
            res.status(203).send("this rent already exist")
        }else{
            await rent.save()
            if(rent){
                res.status(200).send("rent created")
            }else{
                res.status(400).send("error")
            }
        }
    }
}

const getRentByIdUser = async(body,res) => {
    if(!body.id){
        res.status(400).send("all input are required")
    }else{
        const id = Mongoose.Types.ObjectId(body.id)
        const rent = await RentModel.find({fk_user: id})
        if(rent){
            res.status(200).send(rent)
        }else{
            res.status(400).send("dont find rent")
        }
    }
}

const cancelRent = async(body,res) => {
    if(!body.fk_user || !body.fk_pls || !body.fk_place){
        res.status(400).send("all input are required")
    }else{
        const rentExist = await RentModel.findOneAndDelete({fk_pls: body.fk_pls, fk_place: body.fk_place, fk_user: body.fk_user})
        if(rentExist){
            res.status(203).send("delete success")
        }else{
            res.status(400).send("error")
        }
    }
}


module.exports = {createRent, getRentByIdUser, cancelRent}