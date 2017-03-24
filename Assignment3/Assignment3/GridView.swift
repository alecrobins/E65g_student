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
//    var grid: Grid
//    grid = Grid(size, size) { _,_ in CellState.empty }
    
    override func draw(_ rect: CGRect) {
        let size = CGSize(
            width: rect.size.width / 3.0,
            height: rect.size.height / 3.0
        )
        let base = rect.origin
        (0 ..< 3).forEach { i in
            (0 ..< 3).forEach { j in
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
        let lineWidth: CGFloat = 8.0
        
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
        verticalPath.lineWidth = lineWidth
        
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
        horizontalPath.lineWidth = lineWidth
        UIColor.green.setStroke()
        horizontalPath.stroke()
    }

}
