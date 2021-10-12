//
//  ViewController.swift
//  Calculadora
//
//  Created by Rodrigo Baroni on 08/10/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    let mathOperation = MathOperation()

    @IBOutlet weak var displayUILabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
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
        updateDisplay()
    }

    @IBAction func equalsUIButton(_ sender: UIButton) {
        mathOperation.equalsInput()
        updateDisplay()
    }

    private func updateDisplay() {
        displayUILabel.text = mathOperation.display
    }
}
