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
    static let sharedEngine = StandardEngine()
    
    public var delegate: EngineDelegate?
    public var grid: GridProtocol
    public var refreshRate: Double = 0.0
    public var refreshTimer: Timer = Timer.init()
    public var rows: Int = 10 {
        didSet {
            createGrid()
        }
    }
    
    public var cols: Int = 10 {
        didSet {
            createGrid()
        }
    }
    
    private init() {
        self.grid = Grid(rows, cols)
    }
    
    private func createGrid() {
        grid = Grid(rows, cols)
        sendUpdate()
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
