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
    public var firstNumber: String = "0"
    public var mathOperator: MathOperator?
    public var secondNumber: String = ""
    private let displayLimit: Int

    public init(displayLimit: Int = 9) {
        self.displayLimit = displayLimit
    }
}
