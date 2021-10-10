//
//  ViewController.swift
//  Calculadora
//
//  Created by Rodrigo Baroni on 08/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ClearUIButton: UIButton!

    let operation = MathOperation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func NumberUIButtonAction(_ sender: UIButton) {
        //operation.addNumber(sender.titleLabel?.text)
    }
    
}

