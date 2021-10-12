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

    @IBOutlet weak var clearUIButton: UIButton!
    @IBOutlet weak var displayUILabel: UILabel!

    // MARK: Actions

    @IBAction func operatorUIButtonAction(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return }
        let mathOperator = Character(input)
        guard (try? mathOperation.operatorInput(mathOperator)) != nil else { return }
        updateDisplay()
    }
    @IBAction func digitUIButtonAction(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return }
        let digit = Character(input)
        guard (try? mathOperation.digitInput(digit)) != nil else { return }
        clearUIButton.setTitle("C", for: .normal)
        updateDisplay()
    }

    @IBAction func equalsUIButton(_ sender: UIButton) {
        mathOperation.equalsInput()
        updateDisplay()
    }

    @IBAction func clearUIButton(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return }
        if input == "AC" {
            mathOperation.clearAll()
        } else {
            mathOperation.clear()
            clearUIButton.setTitle("AC", for: .normal)
        }
        updateDisplay()
    }

    @IBAction func negativeUIButton(_ sender: UIButton) {
        mathOperation.negativeInput()
        updateDisplay()
    }

    @IBAction func percentUIButton(_ sender: UIButton) {
        mathOperation.percentInput()
        updateDisplay()
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: Helper functions

    private func updateDisplay() {
        displayUILabel.text = mathOperation.display
    }
}
