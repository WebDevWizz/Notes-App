//
//  NoteDetailView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//


import SwiftUI

struct NoteDetailView: View {
    @State var note: Note
    @State var showEditView = false
    
    
    var body: some View {
        VStack{
            Text(note.title)
                .font(.largeTitle).bold()
                .padding(.top, 20.0)
            
            
            Text("\(note.date, formatter: DateFormatter().noteFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .opacity(0.7)
            //Spacer()
            
            Text(note.description)
                .font(.body)
                .padding(.trailing,200)
                .padding(.top,50)
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showEditView = true
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditNoteView(note: $note, myData: SharedData())
        }
    }
}

extension DateFormatter {
    var noteFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    NoteDetailView(note: Note(id: "Default id", title: "Default Note", date: Date(), description: "Default description", category: "Default"))
}

