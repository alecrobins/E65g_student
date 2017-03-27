//
//  ViewController.swift
//  Assignment3
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    private var grid: Grid = Grid(size, size) { _,_ in CellState.empty }
    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    6. Add a button labeled: "Step" which will iterate the grid when pressed using your modified version of Grid  (20 points)
//    When you have completed the assignment, please commit your changes and create a tag titled "assignment-3-submit". Push your commits and the tag to your GitHub repository.

    
    @IBAction func stepButton(_ sender: Any) {
        gridView.grid = gridView.grid.next()
        gridView.setNeedsDisplay()
    }
}

