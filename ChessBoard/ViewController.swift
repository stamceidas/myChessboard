//
//  ViewController.swift
//  ChessBoard
//
//  Created by stamceidas on 11/27/19.
//  Copyright © 2019 stamceidas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ChessDelegate {
    
    
    
    var chessEngine = ChessEngine()

    @IBOutlet weak var boardView: BoardView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        boardView.pieces = chessEngine.pieces
        boardView.setNeedsDisplay()
            
        boardView.chessDelegate = self
    }
    
    func initializeGame(fromCol: Int, fromRow: Int, N: Int) {
        chessEngine.initializeGame(fromCol: fromCol, fromRow: fromRow, N: N)
        boardView.pieces = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
        
    func moveHorse(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            
            boardView.pieces = chessEngine.pieces
            boardView.setNeedsDisplay()
    }
}


