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
        return showLastTerm()
    }
    public enum Error: Swift.Error {
        case invalidInput(Character)
        case calculationError(String)
    }
    private enum Status {
        case justCleared
        case another
    }
    private var calculatorStatus = Status.another

    public init(displayLimit: Int = 9, expression: SimpleExpression = SimpleExpression()) {
        self.displayLimit = displayLimit
        self.expression = expression
    }

    // Helper functions

    private func showLastTerm() -> String {
        if let display = expression.result {
            return display.toCalculatorDisplay
        }
        if let display = expression.rightTerm {
            return display.toCalculatorDisplay
        }
        if let display = expression.leftTerm, calculatorStatus != .justCleared {
            return display.toCalculatorDisplay
        }
        return "0"
    }
}

// MARK: Digit input

extension MathOperation {

    public func digitInput(_ input: Character) throws {
        calculatorStatus = .another
        try validateDigitInput(input)
        let mInput = transformInput(input)
        appendToTerm(mInput)
    }

    // MARK: Helper functions

    private func validateDigitInput(_ input: Character) throws {
        guard input.isValidDigit else {
            throw MathOperation.Error.invalidInput(input)
        }
    }

    private func transformInput(_ input: Character) -> Character {
        if input.isDecimalSeparator {
            return "."
        }
        return input
    }

    private func appendToTerm(_ input: Character) {
        if shouldAppendToLeftTerm() {
            let currentLeftTerm = expression.leftTerm ?? ""
            guard currentLeftTerm.onlyNumbers.count < displayLimit else { return }
            guard !currentLeftTerm.hasDecimal || (currentLeftTerm.hasDecimal && input != ".") else { return }
            expression.leftTerm = "\(currentLeftTerm)\(input)"
        } else {
            let currentRightTerm = expression.rightTerm ?? ""
            guard currentRightTerm.onlyNumbers.count < displayLimit else { return }
            guard !currentRightTerm.hasDecimal || (currentRightTerm.hasDecimal && input != ".") else { return }
            let mInput = input == "," ? "." : input
            expression.rightTerm = "\(currentRightTerm)\(mInput)"
        }
    }

    private func shouldAppendToLeftTerm() -> Bool {
        return expression.mathOperator == nil
    }
}

// MARK: Operator Input

extension MathOperation {

    public func operatorInput(_ input: Character) throws {
        calculatorStatus = .another
        try validateOperatorInput(input)
        let mInput = transformOperatorInput(input)
        expression.mathOperator = MathOperator.init(rawValue: mInput)
    }

    // MARK: Helper functions

    private func validateOperatorInput(_ input: Character) throws {
        guard input.isValidOperator else {
            throw MathOperation.Error.invalidInput(input)
        }
    }

    private func transformOperatorInput(_ input: Character) -> Character {
        if input == "÷" {
            return "/"
        }
        if input == "X" {
            return "*"
        }
        return input
    }
}

// MARK: Equals Input

extension MathOperation {

    public func equalsInput() {
        calculatorStatus = .another
        guard expression.leftTerm != nil,
                expression.mathOperator?.rawValue != nil,
                expression.rightTerm != nil else { return }
        expression.result = try? calculate(expression)
    }

    private func calculate(_ expr: SimpleExpression) throws -> String {
        guard let leftTerm = expr.leftTerm,
                let mathOperator = expr.mathOperator,
              let rightTerm = expr.rightTerm else { throw MathOperation.Error.calculationError("missing data")}
        guard let doubleLeftTerm = Double(leftTerm),
                let doubleRightTerm = Double(rightTerm) else {
                    throw MathOperation.Error.calculationError("missing data")
                }
        var result: Double
        switch mathOperator {
        case .plus:
            result = doubleLeftTerm + doubleRightTerm
        case .division:
            result = doubleLeftTerm / doubleRightTerm
        case .minus:
            result = doubleLeftTerm - doubleRightTerm
        case .multiplication:
            result = doubleLeftTerm * doubleRightTerm
        }
        return result.isNaN ? NSLocalizedString("Erro", comment: "Error") : String(result)
    }
}

// MARK: Clear Operations

extension MathOperation {

    public func clear() {
        calculatorStatus = .justCleared
        if expression.result != nil || expression.rightTerm != nil || expression.mathOperator != nil {
            expression.result = nil
            expression.rightTerm = nil
        } else {
            expression = SimpleExpression()
        }
    }

    public func clearAll() {
        calculatorStatus = .another
        expression = SimpleExpression()
    }
}

// MARK: Negative Button

extension MathOperation {
    public func negativeInput() {
        guard expression.result == nil, expression.leftTerm != nil else { return }
        if let rightTerm = expression.rightTerm {
            if expression.rightTerm?.first == "-" {
                expression.rightTerm = String(rightTerm.dropFirst())
            } else {
                expression.rightTerm = "-\(rightTerm)"
            }
        } else {
            if let leftTerm = expression.leftTerm, expression.mathOperator == nil {
                if leftTerm.first == "-" {
                    expression.leftTerm = String(leftTerm.dropFirst())
                } else {
                    expression.leftTerm = "-\(leftTerm)"
                }
            }
        }
    }
}

// MARK: Percent Button

extension MathOperation {
    public func percentInput() {
        guard expression.result == nil, expression.leftTerm != nil else { return }
        if let rightTerm = expression.rightTerm, let doubleValue = Double(rightTerm) {
            expression.rightTerm = String(doubleValue/100)
        } else {
            if let leftTerm = expression.leftTerm, expression.mathOperator == nil, let doubleValue = Double(leftTerm) {
                expression.leftTerm = String(doubleValue/100)
            }
        }
    }
}
