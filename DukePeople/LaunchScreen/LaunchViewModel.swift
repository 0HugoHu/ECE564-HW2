//
//  LaunchViewModel.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 4/16/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import Combine
import SwiftUI

class LaunchViewModel: ObservableObject {
    @Published var showingUI = false
    
    var tiles = [LaunchTile]()
    
    var textRows = [
        LaunchTextRow(
            text: [
                LaunchText(character: "∮"),
                LaunchText(character: "π"),
                LaunchText(character: "⧑"),
                LaunchText(character: "∞"),
                LaunchText(character: "∴"),
                LaunchText(character: "➤")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "♛"),
                LaunchText(character: "♣︎"),
                LaunchText(character: "♦︎"),
                LaunchText(character: "♥︎"),
                LaunchText(character: "♠︎"),
                LaunchText(character: "♜")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "✭"),
                LaunchText(character: "✣"),
                LaunchText(character: "✿"),
                LaunchText(character: "❂"),
                LaunchText(character: "❃"),
                LaunchText(character: "◼︎")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "𝛴"),
                LaunchText(character: "𝜽"),
                LaunchText(character: "𝛹"),
                LaunchText(character: "𝜔"),
                LaunchText(character: "𝛼"),
                LaunchText(character: "𝛺")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "❖"),
                LaunchText(character: "D", isPartOfFind: true),
                LaunchText(character: "U", isPartOfFind: true),
                LaunchText(character: "K", isPartOfFind: true),
                LaunchText(character: "E", isPartOfFind: true),
                LaunchText(character: "❖")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "∮"),
                LaunchText(character: "π"),
                LaunchText(character: "⧑"),
                LaunchText(character: "∞"),
                LaunchText(character: "∴"),
                LaunchText(character: "➤")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "♛"),
                LaunchText(character: "♣︎"),
                LaunchText(character: "♦︎"),
                LaunchText(character: "♥︎"),
                LaunchText(character: "♠︎"),
                LaunchText(character: "♜")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "✭"),
                LaunchText(character: "✣"),
                LaunchText(character: "✿"),
                LaunchText(character: "❂"),
                LaunchText(character: "❃"),
                LaunchText(character: "◼︎")
            ]
        ),
        LaunchTextRow(
            text: [
                LaunchText(character: "𝛴"),
                LaunchText(character: "𝜽"),
                LaunchText(character: "𝛹"),
                LaunchText(character: "𝜔"),
                LaunchText(character: "𝛼"),
                LaunchText(character: "𝛺")
            ]
        )
    ]
    
    var width: Int {
        textRows.first?.text.count ?? 0
    }
    
    var height: Int {
        textRows.count
    }
}
