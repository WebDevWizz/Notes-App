//
//  ContentView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//

//Codice fatto con URLSession, ma si può implementare anche con Alamo per le richieste HTTP

import SwiftUI


struct ContentView: View {
    @StateObject var myData = sharedData
    @State var search = ""
    @State var ShowAddPage = false //Incrementato quando clicco sul '+' per aggiungere una nota
    @State var ShowAddCategory = false
    @State var selectedCategory = Categories(name: "All")
    
    
    //TODO: RESEARCH CODE + AGGIORNATO AL FILTRAGGIO DELLA CATEGORIA:
    var filteredNotes: [Note] {
            myData.notes.filter { note in
                (selectedCategory.name == "All" || note.category == selectedCategory.name) &&
                (search.isEmpty || note.title.localizedCaseInsensitiveContains(search))
            }
        }
    
    
    //GRIGLIA PER LE NOTE:
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40)
    ]
    
    //---------------
    
    
    var body: some View {
        NavigationStack{
                
                VStack{
                    
                    //Categorie di note
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30){
                            
                            //TODO: SETTARE IL FILTRAGGIO SUI BOTTONI
                            
                            ForEach(myData.categories) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                        RoundedRectangle(cornerRadius: 60)
                                            .stroke(Color.black, lineWidth: 2)
                                            .background(RoundedRectangle(cornerRadius: 15).fill(selectedCategory == category ? Color.gray : Color.white))
                                            .frame(width: 90.0, height: 45.0)
                                            .overlay(
                                                Text(category.name)
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 15))
                                            )
                                    }
                                }
                            
                            Button(action: {
                                ShowAddCategory = true //Per collegarlo con lo sheet AddCategory
                            }){
                                RoundedRectangle(cornerRadius: 60)
                                  .stroke(Color.black, lineWidth: 2) //Imposto contorno nero
                                  .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                                  .frame(width: 50.0, height: 45.0)
                                  .overlay(
                                       Text("+")
                                       .foregroundColor(.black)
                                       //.bold()
                                       .font(.system(size: 20))
                                   )
                            }

                        }
                        .padding(.horizontal)
                        .padding(.top)
                       
                    }

                    Spacer()
                    

                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(filteredNotes, id: \.self) {
                                note in
                                NavigationLink(destination: NoteDetailView(note: note)) {
                                    NoteView(note: note)
                                        .padding()
                                }
                            }
                        }
                        .padding()

                    }
                    .navigationTitle("My Notes")
                    .onAppear{
                        myData.fetchDataFromServer()
                    }
                    .sheet(isPresented: $ShowAddPage) {
                        AddNoteView()
                     }
                    .sheet(isPresented: $ShowAddCategory) {
                        AddCategoryView()
                    }
                   // Spacer()
                
                 
                }//End vstack
                .scrollDisabled(false)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            ShowAddPage = true
                        }) {
                            Image(systemName: "plus")
                             .font(.system(size: 20))
                             .bold()
                             .foregroundColor(.black)
                            }
                    }
                }
        
                        
            
            
        }//end nav. stack
        .searchable(text: $search, prompt: "Search note")
    }
}


#Preview {
    ContentView()
}

