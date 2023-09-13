//
//  GetPath.swift
//  Hugo
//
//  Created by Hugooooo on 9/11/23.
//

import UIKit

/*
 Get the path to the Documents directory
 */
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
