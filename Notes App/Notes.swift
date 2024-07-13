//
//  Notes.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 13/07/24.
//


//File that contacts the server (on VSC) and receives / sends data


//TODO: (Future implementation) Aggiunta del favorite color per colorare il frame della nota dello stesso colore
import Foundation

struct Note : Hashable, Identifiable, Codable {
    var id: String
    var title : String
    var date : Date
    var description : String
    var category: String?
    
     
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case date
        case description
        case category
    }

}
