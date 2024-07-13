//
//  Data.swift
//  Notes App
//
//  Created by Riccardo Ciullini on 16/05/24.
//

import Foundation


extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601: JSONDecoder.DateDecodingStrategy = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return .formatted(formatter)
    }()
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
}




class SharedData : ObservableObject {
    
    @Published var notes: [Note] = []
    @Published var categories = [Categories(name: "All")]//TODO: AGGIUNGI CATEGORIE
    private let baseURL = "http:/192.168.1.56:8081"
    
    
    
    //TODO: Funzioni per interagire con il server:
    func fetchDataFromServer() {
        
        guard let url = URL(string: "\(baseURL)/fetch") else {
                    print("URL non valido")
                    return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Fetch failed: \(error.localizedDescription)")
                        return
                    }
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .customISO8601 //Formato della data
                        let notes = try decoder.decode([Note].self, from: data)
                        
                        DispatchQueue.main.async {
                            self.notes = notes
                        }
                    } catch {
                        print("Error decoding notes: \(error.localizedDescription)")
                        print("Data received: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                }.resume()
    }
    
    func addNoteToServer(note: Note) {
        guard let url = URL(string: "\(baseURL)/create") else {
            print("URL non valido")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(note.title, forHTTPHeaderField: "title")
        request.setValue(note.date.ISO8601Format(), forHTTPHeaderField: "date")
        request.setValue(note.description, forHTTPHeaderField: "description")
        request.setValue(note.category, forHTTPHeaderField: "category")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Add note failed: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let addedNote = try decoder.decode(Note.self, from: data)
                
                DispatchQueue.main.async {
                    self.notes.append(addedNote)
                }
            } catch {
                print("Error decoding added note: \(error.localizedDescription)")
                print("Data received: \(String(data: data, encoding: .utf8) ?? "No data")")
            }
        }.resume()
    }
    

    
        func updateNote(note: Note) {
            guard let url = URL(string: "\(baseURL)/update") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //Anche in questo caso devo settare gli attributi della nota:
            request.setValue(note.id, forHTTPHeaderField: "id")
            request.setValue(note.description, forHTTPHeaderField: "description")
            request.setValue(note.date.ISO8601Format(), forHTTPHeaderField: "date")
            request.setValue(note.category, forHTTPHeaderField: "category")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                
                guard let data = data else {
                    print("No data received!")
                    return
                }
                
                do {
                    //Collegamento della nota al server + update:
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let updatedNote = try decoder.decode(Note.self, from: data)
                    
                    DispatchQueue.main.async {
                        if let index = self.notes.firstIndex(where: { $0.id == updatedNote.id}) {
                            self.notes[index] = updatedNote
                        }
                    }
                } catch {
                    print("Failed to decode update note: \(error)")
                }
            }.resume()
        }
        
        func deleteNote(note: Note) {
            guard let url = URL(string: "\(baseURL)/delete") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //Eliminazione basato sull'id della nota:
            request.setValue(note.id, forHTTPHeaderField: "id")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.notes.removeAll { $0.id == note.id}
                }
            }.resume()
        }
}


let sharedData = SharedData()

