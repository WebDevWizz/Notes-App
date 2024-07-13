//SERVER ORIGINALE

const express = require('express');
const mongoose = require('mongoose');
const Note = require('./noteSchema'); // Importazione dello schema definito in 'noteSchema.js'
const Data = require('./noteSchema');

const app = express();
//app.use(express.json()); // Middleware per il parsing del body JSON

mongoose.connect("mongodb://localhost/newDB"); // Rimosse le opzioni deprecate
mongoose.connection.once("open", () => {
    console.log("Connessione riuscita al DB!");
}).on("error", (error) => {
    console.log("Connessione fallita: " + error);
});



//SCRITTURA DELLE FUNZIONI CRUD (CREATE --> POST, READ = FETCH --> GET, UPDATE --> POST, DELETE --> POST)
app.post("/create", (req, res) => {
   var note = new Data ({
       title: req.get("title"), 
       date: req.get("date"), 
       description: req.get("description"),
       category: req.get("category")
   })

   note.save().then(() => {
      if(note.isNew == false) {
         console.log("Dati salvati!"); 
        // res.send("Dati salvati!")
        res.json(note); 
      } else {
         console.log("Failed to save data.")
      }
   })
});

app.post('/update', async (req, res) => {
    try {
        const updatedNote = await Note.findOneAndUpdate(
            { _id: req.get("id") },
            {
                description: req.get("description"),
                title: req.get("title"),
                date: req.get("date"), 
                category: req.get("category")
            },
            { new: true } // Questa opzione restituisce il documento aggiornato
        );
        res.json(updatedNote);
    } catch (err) {
        console.log("Failed to update: " + err);
        res.status(500).send("Errore durante l'aggiornamento");
    }
});

app.post("/delete", async (req, res) => {
    try {
        await Data.findOneAndDelete({
            _id: req.get("id")
        });
        res.send("Eliminato!");
    } catch (err) {
        console.log("Failed: " + err);
        res.status(500).send("Errore durante l'eliminazione");
    }
});

app.get("/fetch", (req, res) => {
    Data.find({}).then((DBitems) => {
        res.send(DBitems)
    })
});


var server = app.listen(8081, "192.168.1.56", () => {
    console.log("Server is running!");
});
