//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate, GridViewDataSource {

    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedEngine.delegate = self
        gridView.gridDataSource = self
        gridView.gridSize = GridSize(
            StandardEngine.sharedEngine.rows,
            StandardEngine.sharedEngine.cols
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func step(_ sender: UIButton) {
        StandardEngine.sharedEngine.next()
        gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return StandardEngine.sharedEngine.grid[row,col] }
        set { StandardEngine.sharedEngine.grid[row,col] = newValue }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.gridSize = GridSize(
            StandardEngine.sharedEngine.rows,
            StandardEngine.sharedEngine.cols
        )
        gridView.setNeedsDisplay()
    }
}

