//
//  Strings.swift
//  DukePeople
//
//  Created by Hugooooo on 9/6/23.
//

import Foundation

let helpText = """
            --------------------------------------- Help ---------------------------------------
            Format:
            fn=first_name, ln=last_name, em=email,
            ro=role, ge=gender, fr=from
            - ro must be one of: Student, TA, Professor, Staff, or will be Other
            - ge must be one of: Male, Female, otherwise will be Other
            - Either of these parameters must not contains ',', space, or '='
            - The order of parameters does not matter
            
            1. Add: Add a person to the database.
                DUID is required, all other parameters are optional.
            2. Update: Update or add a person with given DUID.
                DUID is required, all other parameters are optional.
            3. Delete: Delete a person with given DUID.
                DUID is required, all other parameters are ignored.
            4. Find: Find a person with given DUID or given name.
                Either DUID or lName is required, fName is default with "*".
                Use "*" to represent any name.
            5. List All: List all people in the database.
            6. Help: Show this help message.
            
            CopyRight: Yadong (Hugo) Hu, 2023
            --------------------------------------------------------------------------------------\n
            """

