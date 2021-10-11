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
    }
}
