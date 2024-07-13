//
//  NoteView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//


import SwiftUI

struct NoteView: View {
    var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.headline)
                .foregroundColor(.white)
            //Spacer()
            HStack{
                Text(note.description)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(1) //Limit the number of lines for the preview
                Spacer()
            }
        }
        .padding()
        .frame(width: 180, height: 130)
        .background(Color.gray)
        .cornerRadius(15)
        .aspectRatio(contentMode: .fill)
        
    }
}


#Preview {
    NoteView(note: Note(id: "Default id", title: "Default Note", date: Date(), description: "Default description", category: "Default"))
}

