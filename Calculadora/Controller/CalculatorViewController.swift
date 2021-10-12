//
//  ViewController.swift
//  Calculadora
//
//  Created by Rodrigo Baroni on 08/10/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: Properties

    let mathOperation = MathOperation()

    // MARK: Outlets

    @IBOutlet weak var displayUILabel: UILabel!
    @IBOutlet weak var clearUIButton: UIButton!

    // MARK: Actions

    @IBAction func numberUIButtonAction(_ sender: UIButton) {
        do {
            guard let stringInput: String = sender.titleLabel?.text else { return }
            try mathOperation.digitInput(Character(stringInput))
            updateDisplay()
        } catch {
            displayUILabel.text = "Erro"
        }
    }

    @IBAction func clearUIButtonAction(_ sender: UIButton) {
        if clearUIButton.currentTitle == "AC" {
            mathOperation.clearAll()
        } else {
            mathOperation.clear()
        }
        updateDisplay()
    }

    @IBAction func operatorUIButtonAction(_ sender: UIButton) {
        do {
            guard let operatorInput: String = sender.titleLabel?.text else { return }
            try mathOperation.operatorInput(Character(operatorInput))
            updateDisplay()
        } catch {
            displayUILabel.text = "Erro"
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Helper methods

    private func updateDisplay() {
        displayUILabel.text = mathOperation.display
        if mathOperation.currentState == .allClear || mathOperation.currentState == .justCleared {
            clearUIButton.setTitle("AC", for: .normal)
        } else {
            clearUIButton.setTitle("C", for: .normal)
        }
        print(">>>>>>>>>>>>>> CURRENT NUMBER  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> \(mathOperation.currentNumber)  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> CURRENT TERM  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> \(mathOperation.currentTerm)  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> EXPRESSION  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> \(mathOperation.expression)  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> DISPLAY  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> \(mathOperation.display)  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> PREVIOUS MATH OPERATOR  <<<<<<<<<<<<<<")
        if let previousOp = mathOperation.previousMathOperator {
        print(">>>>>>>>>>>>>> \(previousOp)  <<<<<<<<<<<<<<")
        } else {
            print(">>>>>>>>>>>>>> NIL  <<<<<<<<<<<<<<")
        }
        print(">>>>>>>>>>>>>> CURRENT MATH OPERATOR  <<<<<<<<<<<<<<")
        if let currentOp = mathOperation.currentMathOperator {
        print(">>>>>>>>>>>>>> \(currentOp)  <<<<<<<<<<<<<<")
        } else {
            print(">>>>>>>>>>>>>> NIL  <<<<<<<<<<<<<<")
        }
        print(">>>>>>>>>>>>>> STATE  <<<<<<<<<<<<<<")
        print(">>>>>>>>>>>>>> \(mathOperation.currentState)  <<<<<<<<<<<<<<")
        print("\n")
        print("\n")
        print("\n")

    }
}
