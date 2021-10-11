//
//  String+Extensions.swift
//  Calculadora
//
//  Created by Fernando Goulart on 10/10/21.
//

extension Character {
    public func isValidCalculatorDigit() -> Bool {
        switch self {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",":
            return true
        default:
            return false
        }
    }
}
