//
//  DataStructures.swift
//  DukePeople
//
//  Created by Hugooooo on 9/5/23.
//

import Foundation

enum Role : String, Codable {
    case Unknown = "Unknown" // has not been specified
    case Professor = "Professor"
    case TA = "TA"
    case Student = "Student"
    case Other = "Other" // has been specified, but is not Professor, TA, or Student
}


enum Gender : String, Codable {
    case Unknown = "Unknown" // has not been specified
    case Male = "Male"
    case Female = "Female"
    case Other = "Other" // has been specified, but is not “Male” or “Female”
}
