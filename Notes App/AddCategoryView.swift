//
//  AddCategoryView.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var myData = sharedData
    @State var newCategory = ""
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            
            Form{
                Section("Name") {
                    TextField("Name", text: $newCategory)
                }
                
            }.navigationTitle("New Category")
                .toolbar{
                    ToolbarItem {
                        Button("Add") {
                            myData.categories.append(Categories(name: newCategory))
                            dismiss() //Chiusura pagina dopo l'aggiunta
                        }
                    }
                }
            
            
            
        } //End NavStack
    }
}

#Preview {
    AddCategoryView()
}

