//
//  Engine.swift
//  Assignment4
//
//  Created by Alec Robins on 4/13/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import Foundation


public protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}

public protocol EngineProtocol {
    var delegate: EngineDelegate? { get }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: Timer { get set }
    var rows: Int { get set }
    var cols: Int { get set }
    func next() -> GridProtocol
}


public class StandardEngine: EngineProtocol {
    static let sharedEngine = StandardEngine(10, 10)
    
    public var delegate: EngineDelegate?
    public var grid: GridProtocol
    public var refreshRate: Double = 0.0
    public var refreshTimer: Timer = Timer.init()
    public var rows: Int
    public var cols: Int
    
    private init(_ rows: Int, _ cols: Int) {
        self.grid = Grid(rows, cols)
        self.rows = rows
        self.cols = cols
    }
    
    private func sendUpdate() {
        delegate?.engineDidUpdate(withGrid: grid)
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        let n = Notification(name: name, object: nil, userInfo: ["engine" : self])
        nc.post(n)
    }
    
    public func next() -> GridProtocol {
        grid = grid.next()
        sendUpdate()
        return grid
    }
}
