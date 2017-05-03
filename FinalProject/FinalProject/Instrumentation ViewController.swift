//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class InstrumentationViewController: UIViewController {

    @IBOutlet weak var rowsStepper: UIStepper!
    @IBOutlet weak var rowTextField: UITextField!
    
    @IBOutlet weak var colsTextField: UITextField!
    @IBOutlet weak var colsStepper: UIStepper!
    
    @IBOutlet weak var refreshRateSlider: UISlider!
    
    @IBOutlet weak var timedRefreshSwitch: UISwitch!
    
    var timerInterval: TimeInterval = 0.0 {
        didSet {
            StandardEngine.sharedEngine.refreshTimer?.invalidate()
            StandardEngine.sharedEngine.refreshTimer = nil
            
            StandardEngine.sharedEngine.refreshTimer =
                Timer.scheduledTimer(
                withTimeInterval: timerInterval,
                repeats: true
            ) { (t: Timer) in
                StandardEngine.sharedEngine.next()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rows = StandardEngine.sharedEngine.rows
        let cols = StandardEngine.sharedEngine.cols
        
        rowTextField.text = String(rows)
        colsTextField.text = String(cols)
        
        rowsStepper.value = Double(rows)
        colsStepper.value = Double(cols)
    }
    
    @IBAction func refreshRateSliderValueChange(_ sender: UISlider) {
        timerInterval = TimeInterval(sender.value / 100.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateStandardEngineGrid() {
        StandardEngine.sharedEngine.grid = Grid(
            StandardEngine.sharedEngine.rows,
            StandardEngine.sharedEngine.cols
        )
    }

    @IBAction func rowsStepperStep(_ sender: UIStepper) {
        StandardEngine.sharedEngine.rows = Int(sender.value)
        rowTextField.text = String(StandardEngine.sharedEngine.rows)
        updateStandardEngineGrid()
    }
    
    @IBAction func colsStepperStep(_ sender: UIStepper) {
        StandardEngine.sharedEngine.cols = Int(sender.value)
        colsTextField.text = String(StandardEngine.sharedEngine.cols)
        updateStandardEngineGrid()
    }

    @IBAction func rowsTextFieldDidEnd(_ sender: UITextField) {
        if let updatedValue = Int(sender.text!) {
            StandardEngine.sharedEngine.rows = updatedValue
            rowsStepper.value = Double(updatedValue)
            updateStandardEngineGrid()
        } else {
            rowTextField.text = String(StandardEngine.sharedEngine.rows)
        }
    }
    
    
    @IBAction func colsTextFieldDidEnd(_ sender: UITextField) {
        if let updatedValue = Int(sender.text!) {
            StandardEngine.sharedEngine.cols = updatedValue
            colsStepper.value = Double(updatedValue)
            updateStandardEngineGrid()
        } else {
            rowTextField.text = String(StandardEngine.sharedEngine.cols)
        }
    }
}

