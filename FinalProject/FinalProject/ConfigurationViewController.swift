//
//  ConfigurationViewController.swift
//  FinalProject
//
//  Created by Alec Robins on 5/3/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController, GridViewDataSource {
    
    @IBOutlet weak var configurationTextView: UITextField!
    @IBOutlet weak var configurationGridView: GridView!
    
    var grid: Grid?
    var configuration: NSDictionary?
    var saveClosure: ((NSDictionary) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        configurationGridView.gridDataSource = self
        
        if self.configuration != nil {
            configurationTextView.text = configuration!["title"] as? String
            let configurationContents = configuration!["contents"] as! [[Int]]
            self.grid = Configurations.contentsToGrid(configurationContents)
            configurationGridView.gridSize = self.grid!.size
        }
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return self.grid![row,col] }
        set { self.grid?[row,col] = newValue }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
