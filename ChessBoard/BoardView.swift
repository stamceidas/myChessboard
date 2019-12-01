//
//  BoardView.swift
//  ChessBoard
//
//  Created by stamceidas on 11/27/19.
//  Copyright © 2019 stamceidas. All rights reserved.
//

import UIKit

class BoardView: UIView{
    var length : CGFloat = 0.0
    var squareWidth : CGFloat = 0.0
    var pieces = Set<Knight>()
    
    var chessDelegate: ChessDelegate?
    var fromCol: Int = -1
    var fromRow: Int = -1
    var startLocation = CGPoint.zero
    var touchLocations: [CGPoint] = []

    override func didMoveToSuperview() {
        self.frame.size.width = 8 * squareWidth
        self.frame.size.height = 8 * squareWidth
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        length = 16.0
        squareWidth = self.viewWidth / length
        self.layer.borderWidth = 2.0
        
    }
    
    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        self.startLocation = touch.location(in: self)
        
        fromCol = Int(self.startLocation.x / squareWidth)
        fromRow = Int(self.startLocation.y / squareWidth)
        print(fromCol,fromRow)
        chessDelegate?.initializeGame(fromCol: fromCol, fromRow: fromRow, N: Int(length))

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let myTouch = touches.first {
            self.touchLocations.append(myTouch.location(in: self))
        }
        
        let touch = touches.first!
        let fingerLocation = touch.location(in: self)
        let toCol = Int(fingerLocation.x / squareWidth)
        let toRow = Int(fingerLocation.y / squareWidth)
        if  0...Int(length-1) ~= toCol && 0...Int(length-1) ~= toRow {
            chessDelegate?.moveHorse(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            drawLineFromPoint(start: startLocation, toPoint: fingerLocation, ofColor: .black)
            
        }
    }
    
    func drawBoard() {
        for i in stride(from: 0, to: length, by: 2) {
            drawTwoRowsAt(y: CGFloat(CGFloat(i) * squareWidth))
        }
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor) {

        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)

        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0

        self.layer.addSublayer(shapeLayer)
    }
    
    func drawPieces() {
        for piece in pieces {
            let pieceImage = UIImage(named: piece.imageName)
            pieceImage?.draw(in: CGRect(x: CGFloat(piece.col) * squareWidth, y: CGFloat(piece.row) * squareWidth, width: squareWidth, height: squareWidth))
        }
    }
    
    func drawTwoRowsAt(y: CGFloat) {
        for i in 0...Int(length)-1 {
            if i.isMultiple(of: 2) {
                drawSquareAt(x: CGFloat(CGFloat(i) * squareWidth), y: y + squareWidth)
            }
            else {
                drawSquareAt(x: CGFloat(CGFloat(i) * squareWidth), y: y)
            }
        }
    }
    
    func drawSquareAt(x: CGFloat, y: CGFloat) {
        let path = UIBezierPath(rect: CGRect(x: x, y: y, width: squareWidth, height: squareWidth))
        UIColor.lightGray.setFill()
        path.fill()
    }
}

extension BoardView {
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }

    public var viewHeight: CGFloat {
        return self.frame.size.height
    }
}
