//
//  Configurations.swift
//  FinalProject
//
//  Created by Alec Robins on 5/3/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import Foundation

let finalProjectURL = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"

public class Configurations {
    static let sharedConfigurations = Configurations()
    
    static func contentsToGrid(_ contents: [[Int]]) -> Grid {
        var maxSize: Int = 0
        contents.forEach {gridPosition in
            let row = gridPosition[0]
            let col = gridPosition[1]
            if max(row, col) > maxSize {
                maxSize = max(row, col)
            }
        }
        
        maxSize = maxSize * 2
        
        var grid = Grid(maxSize, maxSize)
        contents.forEach {gridPosition in
            let row = gridPosition[0]
            let col = gridPosition[1]
            grid[row, col] = .alive
        }
        
        return grid
    }
    
    public var configurations = [NSDictionary]()
    
    private init() {}
    
    public func addConfiguratoins(_ newConfigurations: [NSDictionary]) {
        configurations += newConfigurations
        sendUpdate()
    }
    
    private func sendUpdate() {
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "ConfigurationsUpdate")
        let n = Notification(name: name, object: nil, userInfo: ["configurations" : self])
        nc.post(n)
    }
    
    public func initialfetchConfigurations() {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) { (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
            
            let newConfigurations = json as! [NSDictionary]
            self.configurations += newConfigurations
            self.sendUpdate()
            
//            let jsonDictionary = jsonArray[0] as! NSDictionary
//            let jsonTitle = jsonDictionary["title"] as! String
//            let jsonContents = jsonDictionary["contents"] as! [[Int]]
//            print (jsonTitle, jsonContents)
//            OperationQueue.main.addOperation {
//                self.textView.text = resultString
//            }
        }
    }
}


