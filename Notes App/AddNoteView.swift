//
//  AddNoteView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//


import SwiftUI

struct AddNoteView: View {
    @ObservedObject var myData = sharedData
    @State var newtitle = ""
    @State var newdescription = ""
    @State var newcategory = ""
    @Environment(\.presentationMode) var presentationMode
   // @State var color = Color.accentColor
    
    var body: some View {
        NavigationStack{
            
            NavigationView{
        
                VStack{
                    //Title
                    TextField("TITLE", text: $newtitle)
                        .padding()
                        .foregroundColor(.black).bold()
                        .font(.system(size: 42))
                    
                    //TextEditor per wrapping automatico, ovvero andare a capo quando si scrive
                    TextEditor(text: $newdescription)
                        .padding(.horizontal)
                    
                    Text("\(Date(), formatter: DateFormatter().noteFormatter)")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                .padding(.top,-42)
                
                
                
                //TODO: CODICE PER TOOLBAR
                .toolbar{
                    ToolbarItem {//toolbar elements
                        Button(action: {
                            //TODO: IMPLEMENTARE L'AZIONE PER ELENCO PUNTATO
                            //TODO: Una volta che ci clicco sopra, viene visualizzata una View per poter aggiungere la nota ad una determinata categoria
                            
                            
                        }, label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .frame(width: 50, height: 40)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(60)
                                //.opacity(0.6)
                        })
                    }
                    
                }
                .navigationBarItems(leading: Button(action: {
                    addNote()
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                        Image(systemName: "chevron.backward.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 25))
                        .opacity(0.6)
                    
                })
                
            }
            
        } 
        
    }
    
    func addNote() {
            //Check:
            print("Add note..")
            let newNote = Note(
                id: UUID().uuidString, //Per generare un ID univoco per la nota
                title: newtitle.trimmingCharacters(in: .whitespacesAndNewlines),
                date: Date(),
                description: newdescription.trimmingCharacters(in: .whitespacesAndNewlines),
                category: "All" //Categoria di default
            )
        myData.addNoteToServer(note: newNote)
        }

}

#Preview {
    AddNoteView()
}

