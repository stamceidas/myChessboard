//
//  ChessDelegate.swift
//  ChessBoard
//
//  Created by stamceidas on 11/29/19.
//  Copyright © 2019 stamceidas. All rights reserved.
//

import Foundation

protocol ChessDelegate {
    func moveHorse(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func initializeGame(fromCol: Int, fromRow: Int, N: Int)
}
