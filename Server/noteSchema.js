//Questo file:
//definisce uno schema Mongoose per le note, 
//crea un modello Mongoose basato su questo schema e lo esporta per l'uso in altri file dell'applicazione.

const mongoose = require("mongoose") //Importazione modulo mongoose
const Schema = mongoose.Schema //Creazione Schema

const note = new Schema({

    title: { type: String, required: true}, 
    description: { type: String, required: true}, 
    date: { type: Date, default: Date.now},
    category: { type: String, required: true}
})

//Trasferimento di questo file al 'server.js' (FONDAMENTALE): 
const Data = mongoose.model("Data", note) //Creazione di un MODELLO MONGOOSE usando lo schema Note (vedi quad. per appr.)

module.exports = Data //Esportazione