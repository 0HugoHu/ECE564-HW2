//
//  DataModel.swift
//  DukePeople
//
//  Created by Hugooooo on 9/5/23.
//

import Foundation
import UIKit

// Duke Person Data Model
struct DukePerson : CustomStringConvertible, Codable {
    let DUID: Int
    var fName: String
    var lName: String
    var email: String
    var from: String
    var gender: Gender
    var role: Role
    var program: String
    var plan: String
    var picture: String
    
    
    // Custom description
    var description: String {
        let pronoun: (subject: String, object: String)
        switch gender {
        case .Male:
            pronoun = ("He", "Him")
        case .Female:
            pronoun = ("She", "Her")
        default:
            pronoun = ("They", "Them")
        }
        if role == .Student {
            return "\(fName) \(lName) is a Student. \(pronoun.subject) is in the \(program) program working towards a \(plan) degree. You can reach \(pronoun.object.lowercased()) at \(email)."
        } else {
            return "\(fName) \(lName) is a \(role). \(pronoun.subject) is from \(from). You can reach \(pronoun.object.lowercased()) at \(email)."
        }
    }
    
    init(DUID: Int, fName: String, lName: String, email: String, from: String, gender: Gender, role: Role) {
        self.DUID = DUID
        self.fName = fName
        self.lName = lName
        self.email = email
        self.from = from
        self.gender = gender
        self.role = role
        self.program = ""
        self.plan = ""
        self.picture = ""
    }
    
    init(DUID: Int, fName: String, lName: String, email: String, from: String, gender: Gender, role: Role, program: String, plan: String, picture: String) {
        self.DUID = DUID
        self.fName = fName
        self.lName = lName
        self.email = email
        self.from = from
        self.gender = gender
        self.role = role
        self.program = program
        self.plan = plan
        self.picture = picture
    }
}


// Duke Person Dictionary
class DukePersonDict {
    // A dictionary to store DukePerson objects
    var people: [Int : DukePerson]
    let url: URL
    
    
    init(url: URL) {
        self.people = [Int : DukePerson]()
        self.url = url
        if !load(url) {
            // TODO: Handle error
        }
        if !save() {
            // TODO: Handle error
        }
    }
    
    
    /*
     If the "newPerson.DUID" is not already in the database, add newPerson to the
     database and return true. Otherwise return false.
     */
    func add(_ newPerson: DukePerson) -> Bool {
        if people[newPerson.DUID] != nil {
            return false
        }
        people[newPerson.DUID] = newPerson
        return true
    }
    
    
    /*
     Looks for the "updatedPerson.DUID" in the database. If found, replaces that entry, and returns
     true. If not found, then adds "updatedPerson" to database and returns false.
     */
    func update(_ updatedPerson: DukePerson) -> Bool {
        let existingPerson = people[updatedPerson.DUID] != nil
        if !existingPerson {
            people[updatedPerson.DUID] = updatedPerson
            return false
        }
        // Update properties based on non-nil and non-empty values in updatedPerson
        if !updatedPerson.fName.isEmpty {
            people[updatedPerson.DUID]!.fName = updatedPerson.fName
        }
        
        if !updatedPerson.lName.isEmpty {
            people[updatedPerson.DUID]!.lName = updatedPerson.lName
        }
        
        if !updatedPerson.email.isEmpty {
            people[updatedPerson.DUID]!.email = updatedPerson.email
        }
        
        if !updatedPerson.from.isEmpty {
            people[updatedPerson.DUID]!.from = updatedPerson.from
        }
        
        if updatedPerson.gender != .Unknown {
            people[updatedPerson.DUID]!.gender = updatedPerson.gender
        }
        
        if updatedPerson.role != .Unknown {
            people[updatedPerson.DUID]!.role = updatedPerson.role
        }
       
        return true
    }
    
    
    /*
     Looks for "DUID" entry in database. If found, remove the entry from the
     database and return true. If not found, return false.
     */
    func delete(_ DUID: Int) -> Bool {
        if people[DUID] == nil {
            return false
        }
        people.removeValue(forKey: DUID)
        return true
    }
    
    
    /*
     Searches for an entry with "DUID". If found, returns the info as an Optional DukePerson.
     If not found, returns nil.
     */
    func find(_ DUID: Int) -> DukePerson? {
        return people[DUID]
    }
    
    
    /*
     Finds all the people in the database that match the given lastName and firstName.
     The firstName parameter is defaulted, so you can also call the method with just the lastName.
     If “*” is specified for both lastName and firstName, return everyone in the database.
     If no matches found, returns nil
     */
    func find(lastName lName: String, firstName fName: String = "*") -> [DukePerson]? {
        if lName == "*" && fName == "*" {
            // Return everyone in the dictionary
            return Array(people.values)
        } else {
            // Find people based on lastName and firstName
            let filteredPeople = people.values.filter { person in
                if lName == "*" {
                    return person.fName.lowercased() == fName.lowercased()
                } else if fName == "*" {
                    return person.lName.lowercased() == lName.lowercased()
                } else {
                    return person.lName.lowercased() == lName.lowercased() && person.fName.lowercased() == fName.lowercased()
                }
            }
            
            if filteredPeople.isEmpty {
                return nil
            } else {
                return Array(filteredPeople)
            }
        }
    }
    
    
    /*
     Returns a formatted list of all entries in the database,
     for example “1. Ric Telford, Professor, ric.telford@duke.edu – 0664541”
     */
    func list() -> String {
        var result = ""
        for (index, person) in people.values.enumerated() {
            result += "\(index + 1). \(person.fName) \(person.lName), \(person.role.rawValue), \(person.email) – \(person.DUID)\n"
        }
        return result
    }
    
    
    /*
     Reads a JSON file as designated by url, decodes it, and replaces the existing
     data model with the entries from the JSON file. Returns true if everything worked OK,
     false if it doesn’t.
     */
    func load(_ url: URL) -> Bool {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: url.path) {
            // Load data from the JSON file if it exists
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.people = try decoder.decode([Int: DukePerson].self, from: data)
                return true
            } catch {
                // TODO: Handle error
                print("Error loading data from JSON file: \(error)")
                return false
            }
        } else {
            // Load data from an asset file if the JSON file does not exist
            if let assetData = NSDataAsset(name: "PeopleJSON")?.data {
                do {
                    let decoder = JSONDecoder()
                    let dukePeopleArray = try decoder.decode([DukePerson].self, from: assetData)
                    self.people = [:]
                    for dukePerson in dukePeopleArray {
                        self.people[dukePerson.DUID] = dukePerson
                    }
                    return true
                } catch {
                    // TODO: Handle error
                    print("Error loading data from asset: \(error)")
                    return false
                }
            } else {
                // TODO: Handle error
                print("Asset file 'ece564class.json' not found.")
                return false
            }
        }
    }
    
    
    /*
     Converts the current data model entries to JSON and writes the JSON string to a pre-determined filename.
     Returns true if everything works OK, false if it doesn’t.
     */
    func save() -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.people)
            try data.write(to: self.url)
            return true
        } catch {
            // TODO: Handle error
            print("Error saving data: \(error)")
            return false
        }
    }
}

