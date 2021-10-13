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

public struct SimpleExpression: Equatable {
    public var leftTerm: String?
    public var rightTerm: String?
    public var mathOperator: MathOperator?
    public var result: String?

    public init(leftTerm: String? = nil, rightTerm: String? = nil, mathOperator: MathOperator? = nil) {
        self.leftTerm = leftTerm
        self.rightTerm = rightTerm
        self.mathOperator = mathOperator
    }
}

public final class MathOperation {

    public private(set) var expression: SimpleExpression
    private let displayLimit: Int
    public var display: String {
        return expression.leftTerm?.toCalculatorDisplay ?? "0"
    }
    public enum Error: Swift.Error {
        case invalidInput(Character)
        case calculationError(String)
    }

    public func digitInput(_ input: Character ) throws {
        guard input.isNumber || input == "," else {
            throw MathOperation.Error.invalidInput(input)
        }
        let leftTerm: String = expression.leftTerm ?? ""
        let mInput = transformInput(input)
        guard isFirstDecimal(digit: mInput, term: leftTerm) ||  mInput != "." else { return }
        guard isSmallerThanLimit(leftTerm) else { return }
        expression.leftTerm = "\(leftTerm)\(mInput)"
    }

    private func isSmallerThanLimit(_ term: String) -> Bool {
        return term.onlyNumbers.count < displayLimit
    }

    private func transformInput(_ digit: Character) -> Character {
        return digit == "," ? "." : digit
    }

    private func isFirstDecimal(digit: Character, term: String) -> Bool {
        return digit == "." && !term.hasDecimal
    }

    public init(displayLimit: Int = 9, expression: SimpleExpression = SimpleExpression()) {
        self.displayLimit = displayLimit
        self.expression = expression
    }

}

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
        let result = self.map {
            $0 == "." ? "," : $0
        }
        return String(result)
    }
}
