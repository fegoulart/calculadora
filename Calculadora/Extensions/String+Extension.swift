//
//  String+Extension.swift
//  Calculadora
//
//  Created by Fernando Goulart on 12/10/21.
//

import Foundation

extension String {
    var onlyNumbers: String {
        self.filter {
            "0123456789".contains($0)
        }
    }

    var hasDecimal: Bool {
        return self.contains(".")
    }

    var toCalculatorDisplay: String {
        let input = self == "." ? "0." : self
        guard let doubleNumber: Double = Double(input) else { return input }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        let number = doubleNumber as NSNumber
        var display = formatter.string(from: number) ?? input
        if input.last == "." {
            let decimalSeparator: String = Locale.current.decimalSeparator ?? ","
            display = "\(display)\(decimalSeparator)"
        }
        return display
    }
}
