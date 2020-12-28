//
//  ViewController.swift
//  Calculator
//
//  Created by Denis on 27.12.2020.
//
import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var displayResultLabel: UILabel!
  var stillTyping = false
  var firstOperand: Double = 0
  var secondOperand: Double = 0
  var operationSign: String = ""
  var dotIsPlaced = false
  
  var currentInput: Double {
    get {
      return Double(displayResultLabel.text!)!
    } set {
      let value = "\(newValue)"
      let valueArray = value.components(separatedBy: ".")
      if valueArray[1] == "0" {
        displayResultLabel.text = "\(valueArray[0])"
      } else {
        displayResultLabel.text = "\(newValue)"
      }
      stillTyping = false
    }
  }
  
  @IBAction func pressNumber(_ sender: UIButton) {
    
    let number = sender.currentTitle!
    
    if stillTyping {
      if displayResultLabel.text!.count < 10 {
      displayResultLabel.text = displayResultLabel.text! + number
      }
    } else {
      displayResultLabel.text = number
      stillTyping = true
    }
  }
  
  @IBAction func twoOperandOperation(_ sender: UIButton) {
    operationSign = sender.currentTitle!
    firstOperand = currentInput
    stillTyping = false
    dotIsPlaced = false
  }
  
  func operateWithTowOperands(operation: (Double, Double) -> Double) {
    currentInput = operation(firstOperand, secondOperand)
    stillTyping = false
  }
  
  @IBAction func equalitySingPresed(_ sender: UIButton) {
    if stillTyping {
      secondOperand = currentInput
    }
    
    dotIsPlaced = false
    
    switch operationSign {
    case "+":
      operateWithTowOperands {$0 + $1}
    case "-":
      operateWithTowOperands {$0 - $1}
    case "/":
      operateWithTowOperands {$0 / $1}
    case "x":
      operateWithTowOperands {$0 * $1}
    default:
      break
    }
  }
  
  @IBAction func clearButtonPressed(_ sender: UIButton) {
    currentInput = 0
    firstOperand = 0
    secondOperand = 0
    displayResultLabel.text = "\u{1F385}\u{1F381}\u{1F384}"
    stillTyping = false
    operationSign = ""
    dotIsPlaced = false
  }
  
  @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
    currentInput = -currentInput
  }
  
  @IBAction func percentButtonPressed(_ sender: UIButton) {
    if firstOperand == 0 {
      currentInput = currentInput / 100
    } else {
      secondOperand = firstOperand * currentInput / 100
    }
    stillTyping = false
  }
  
  @IBAction func dotButtonPressed(_ sender: UIButton) {
    if stillTyping && !dotIsPlaced {
      displayResultLabel.text = displayResultLabel.text! + "."
      dotIsPlaced = true
    } else if !stillTyping && !dotIsPlaced {
      displayResultLabel.text = "0."
      stillTyping = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
}

