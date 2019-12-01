//
//  ChessEngine.swift
//  ChessBoard
//
//  Created by stamceidas on 11/29/19.
//  Copyright © 2019 stamceidas. All rights reserved.
//

import Foundation

struct ChessEngine {
    var pieces = Set<Knight>()
    
    fileprivate let knightMoves = [
        [ 2, -1],
        [ 2,  1],
        [-2,  1],
        [-2, -1],
        [ 1,  2],
        [ 1, -2],
        [-1,  2],
        [-1, -2]
    ]
    
    func pieceAt(col: Int, row: Int) -> Knight? {
        for piece in pieces {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil
    }
    
    func checkIfPossiblePossession(currentPosition: [Int]) -> [[Int]] {
        var positions: [[Int]] = []
        for km in knightMoves {
            let position = zip(currentPosition, km).map(+)
            positions.append(position)
            
        }
        return positions
    }
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return
        }
        pieces.remove(movingPiece)
        let positions1 = checkIfPossiblePossession(currentPosition: [fromCol, fromRow])
        
        for pos in positions1 {
            let positions2 = checkIfPossiblePossession(currentPosition: [pos.first!, pos.last!])

            for pos in positions2 {
                let positions3 = checkIfPossiblePossession(currentPosition: [pos.first!, pos.last!])

                for pos in positions3 {
                    pieces.insert(Knight(col: pos.first!, row: pos.last!))
                }
            }
        }
        
    }
    
    mutating func initializeGame(fromCol: Int, fromRow: Int, N: Int) {
        pieces.removeAll()
        pieces.insert(Knight(col: fromCol, row: fromRow))
        
    }
    
}
