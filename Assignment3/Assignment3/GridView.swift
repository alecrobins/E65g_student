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
    
    override init(frame: CGRect) {
        self.grid = Grid(size, size) { _,_ in CellState.empty }
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawRectangle(rect)
    }
    
    //4. implement a drawRect: method for GridView which: (40 points)
    //•	draws the correct set of grid lines in the view using the techniques shown in class.  Set the gridlines to have width as specified in the gridWidth property and color as in gridColor
    //•	draws a circle inside of every grid cell and fills the circle with the appropriate color for the grid cell drawn from the Grid struct discussed in Problem 2.  e.g. for grid cell (0,0) fetch the zero'th array from grid and then fetch the CellState value from the zero'th position of the array and color the circle using the color specified in IB. Repeat for the other values
    
    func drawRectangle(_ rect: CGRect) {
        let rectSize = CGFloat(self.size)
        
        let size = CGSize(
            width: rect.size.width / rectSize,
            height: rect.size.height / rectSize
        )
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
                if arc4random_uniform(2) == 1 {
                    let path = UIBezierPath(ovalIn: subRect)
                    livingColor.setFill()
                    path.fill()
                }
            }
        }
        
        //create the path
        let verticalPath = UIBezierPath()
        var start = CGPoint(
            x: rect.origin.x + rect.size.width / 2.0,
            y: rect.origin.y
        )
        var end = CGPoint(
            x: rect.origin.x + rect.size.width / 2.0,
            y: rect.origin.y + rect.size.height
        )
        
        //set the path's line width to the height of the stroke
        verticalPath.lineWidth = self.gridWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        verticalPath.move(to: start)
        
        //add a point to the path at the end of the stroke
        verticalPath.addLine(to: end)
        
        //draw the stroke
        UIColor.cyan.setStroke()
        verticalPath.stroke()
        
        let horizontalPath = UIBezierPath()
        start = CGPoint(
            x: rect.origin.x,
            y: rect.origin.y + rect.size.height / 2.0
        )
        end = CGPoint(
            x: rect.origin.x + rect.size.width,
            y: rect.origin.y + rect.size.height / 2.0
        )
        //move the initial point of the path
        //to the start of the horizontal stroke
        horizontalPath.move(to: start)
        
        //add a point to the path at the end of the stroke
        horizontalPath.addLine(to: end)
        horizontalPath.lineWidth = self.gridWidth
        UIColor.green.setStroke()
        horizontalPath.stroke()
    }

}
