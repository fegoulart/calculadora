//
//  String+Extensions.swift
//  Calculadora
//
//  Created by Fernando Goulart on 10/10/21.
//

extension Character {
    public var isValidCalculatorDigit: Bool {
        switch self {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",":
            return true
        default:
            return false
        }
    }

    public var isValidOperatorInput: Bool {
        if self == "X" || self == "+" || self == "-" || self == "÷" {
            return true
        }
        return false
    }
}
