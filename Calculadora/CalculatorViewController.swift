//
//  ViewController.swift
//  Calculadora
//
//  Created by Rodrigo Baroni on 08/10/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var clearUIButton: UIButton!

    let operation = MathOperation()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numberUIButtonAction(_ sender: UIButton) {
    }
}
