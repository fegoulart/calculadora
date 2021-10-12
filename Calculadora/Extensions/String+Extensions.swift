//
//  String+Extensions.swift
//  Calculadora
//
//  Created by Fernando Goulart on 11/10/21.
//

import Foundation

extension String {
    func noDecimalYet() -> Bool {
        return !self.contains(".")
    }

    var toCalculatorDisplay: String {
        guard let doubleNumber: Double = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        let number = doubleNumber as NSNumber
        var display = formatter.string(from: number) ?? self
        if self.last == "." {
            let decimalSeparator: String = Locale.current.decimalSeparator ?? ","
            display = "\(display)\(decimalSeparator)"
        }
        return display
    }

    var onlyNumbers: String {
        self.filter {
            "0123456789".contains($0)
        }
    }

    var noEndingOperator: String {
        if self.last == "+" || self.last == "-" || self.last == "/" || self.last == "*" {
            return String(self.dropLast())
        }
        return self
    }
}
