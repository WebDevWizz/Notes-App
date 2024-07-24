//
//  EditNoteView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//


import SwiftUI

struct EditNoteView: View {
    @Binding var note: Note
    @ObservedObject var myData: SharedData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextEditor(text: $note.description)
                .padding()
                .border(Color.gray, width: 1)
            
            Button(action: {
                myData.updateNote(note: note)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Salva")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                myData.deleteNote(note: note)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Elimina")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}



//Struct per gestire il binding con la preview:
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper(Note(id: "Default id", title: "Default Note", date: Date(), description: "Default", category: "Default")) {
        EditNoteView(note: $0, myData: SharedData())
    }
}


