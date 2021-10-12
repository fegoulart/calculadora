//
//  Operation.swift
//  Calculadora
//
//  Created by Fernando Goulart on 10/10/21.
//

import Foundation

public enum MathOperator: Character {
    case plus = "+"
    case minus = "-"
    case division = "/"
    case multiplication = "*"
}

public final class MathOperation {

    private var inputs: [String] = []
    private let displayLimit: Int

    public var firstNumber: String {
        return inputs[0]
    }
    public var mathOperator: Character {
        return Character(inputs[1])
    }
    public var secondNumber: String {
        return inputs[2]
    }

    public init(displayLimit: Int = 9) {
        self.displayLimit = displayLimit
    }
}
