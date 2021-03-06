//
//  GridView.swift
//  Assignment3
//
//  Created by Alec Robins on 3/23/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    @IBInspectable var size = 20
    @IBInspectable var livingColor = UIColor.green
    @IBInspectable var emptyColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
    @IBInspectable var bornColor = UIColor.lightGray
    @IBInspectable var diedColor = UIColor.red
    @IBInspectable var gridColor = UIColor.black
    @IBInspectable var gridWidth: CGFloat = 2.0
    var grid: Grid
    
    // Updated since class
    private var lastTouchedPosition: Position?
    
    override init(frame: CGRect) {
        grid = Grid(size, size) { _,_ in CellState.empty }
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        grid = Grid(size, size) { _,_ in CellState.empty }
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        drawRectangle(rect)
    }
    
    func drawRectangle(_ rect: CGRect) {
        let rectSize = CGFloat(self.size)
        
        let size = CGSize(
            width: rect.size.width / rectSize,
            height: rect.size.height / rectSize
        )
        
        // fill in the circles
        let base = rect.origin
        (0 ..< self.size).forEach { i in
            (0 ..< self.size).forEach { j in
                let origin = CGPoint(
                    x: base.x + (CGFloat(i) * size.width),
                    y: base.y + (CGFloat(j) * size.height)
                )
                
                let subRect = CGRect(
                    origin: origin,
                    size: size
                )
                
                var fillColor: UIColor
                
                switch self.grid[(i, j)] {
                case .alive: fillColor = self.livingColor
                case .born: fillColor = self.bornColor
                case .died: fillColor = self.diedColor
                case .empty: fillColor = self.emptyColor
                }
                
                let path = UIBezierPath(ovalIn: subRect)
                fillColor.setFill()
                path.fill()
            }
        }

        //create the grid
        (0 ... self.size).forEach {
            drawLine(
                start: CGPoint(x: CGFloat($0)/rectSize * rect.size.width, y: 0.0),
                end:   CGPoint(x: CGFloat($0)/rectSize * rect.size.width, y: rect.size.height)
            )
            
            drawLine(
                start: CGPoint(x: 0.0, y: CGFloat($0)/rectSize * rect.size.height ),
                end: CGPoint(x: rect.size.width, y: CGFloat($0)/rectSize * rect.size.height)
            )
        }
    }
    
    func drawLine(start:CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        path.lineWidth = self.gridWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        path.move(to: start)
        
        //add a point to the path at the end of the stroke
        path.addLine(to: end)
        
        //draw the stroke
        self.gridColor.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    
    func process(touches: Set<UITouch>) -> Position? {
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        
        let cellValue = grid[(pos.row, pos.col)]
        grid[(pos.row, pos.col)] = cellValue.toggle(value: cellValue)
        
        setNeedsDisplay()
        return pos
    }
    
    func convert(touch: UITouch) -> Position {
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let row = touchX / gridWidth * CGFloat(self.size)
        
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let col = touchY / gridHeight * CGFloat(self.size)
        
        return Position(row: Int(row), col: Int(col))
    }

}
