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
        if self == "0." {
            let decimalSeparator: String = Locale.current.decimalSeparator ?? ","
            return "0\(decimalSeparator)"
        }
        guard let doubleNumber: Double = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        let number = doubleNumber as NSNumber
        return formatter.string(from: number) ?? self
    }
}
