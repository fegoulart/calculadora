//
//  Character+Extension.swift
//  Calculadora
//
//  Created by Fernando Goulart on 12/10/21.
//

extension Character {
    var isValidDigit: Bool {
        if self.isNumber || self == "," {
            return true
        }
        return false
    }

    var isDecimalSeparator: Bool {
        if self == "," {
            return true
        }
        return false
    }

    var isValidOperator: Bool {
        if self == "X" || self == "÷" || self == "+" || self == "-" {
            return true
        }
        return false
    }
}
