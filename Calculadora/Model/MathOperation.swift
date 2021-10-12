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
    case division = "/" // Edit -> Emoji Symbols OR Control+Command+Space
    case multiplication = "*"
}

public enum CalculatorState {
    case allClear
    case justCleared
    case firstDigit
    case otherDigits
    case mathOperator
}

public final class MathOperation {
    public var currentNumber: String = "0"
    public var currentMathOperator: MathOperator? = MathOperator.plus
    public var expression: String = ""
    public var currentTerm: [String] = []
    public private(set) var currentState = CalculatorState.allClear
    private let displayLimit: Int

    public enum Error: Swift.Error {
        case invalidInput(Character)
    }

    public var display: String {
        print(">>>>>>>>> isSameOperatorType \(isSameOperatorType())  <<<<<<<<<<<<")
        if currentState != .mathOperator {
            return currentNumber.toCalculatorDisplay
        }
        if isSameOperatorType() {
            return calculateExpression(currentTerm)
        }
        return currentNumber.toCalculatorDisplay
    }

    private func calculateExpression(_ expr: [String]) -> String {
        let expression = expr.joined().noEndingOperator
        let mNsExpression =  NSExpression(format: expression)
        if let result = mNsExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            return "\(result)"
        } else {
            assert(1==0)
            return expression
        }
    }

    public var previousMathOperator: MathOperator? {
        if currentTermHasOperator() {
            guard let previousOperator: Character = getPreviousOperatorRawValue() else { return nil }
            guard let mOperator = MathOperator.init(rawValue: previousOperator ) else { return nil }
            return mOperator
        } else {
            return MathOperator.plus
        }
    }

    private var currentTermExp: String {
        if currentTerm.count == 0 {
            return ""
        }
        return currentTerm.joined()
    }

    public init(displayLimit: Int = 9) {
        self.displayLimit = displayLimit
    }

    // MARK: Helper functions

    private func currentTermHasOperator() -> Bool {
        return currentTermExp.contains("+") || currentTermExp.contains("-") || currentTermExp.contains("*") || currentTermExp.contains("/")
    }

    private func isARightZero() -> Bool {
        guard currentNumber.count > 0 else { return true }
        return currentNumber != "0"
    }

    private func getPreviousOperatorRawValue() -> Character? {
        var previousOperator: Character?
        for index in (0...currentTerm.lastIndex).reversed() {
            let value = currentTerm[index]
            if value.contains("+") {
                previousOperator = Character("+")
                break
            }
            if value.contains("-") {
                previousOperator = Character("-")
                break
            }
            if value.contains("/") {
                previousOperator = Character("/")
                break
            }
            if value.contains("*") {
                previousOperator = Character("*")
                break
            }
        }
        return previousOperator
    }
}

// MARK: Clear Operations

extension MathOperation {
    public func clear() {
        currentNumber = "0"
        self.currentState = CalculatorState.justCleared
    }

    public func clearAll() {
        currentNumber = "0"
        currentState = CalculatorState.allClear
        currentTerm = ["0"]
        expression = ""
    }
}

// MARK: Digit input

extension MathOperation {
    public func digitInput(_ digit: Character) throws {
        assert(digit.isValidCalculatorDigit)
        guard digit.isValidCalculatorDigit else { throw MathOperation.Error.invalidInput(digit) }
        assert(currentNumber.onlyNumbers.count < displayLimit)
        guard currentNumber.onlyNumbers.count < displayLimit else { return }
        digitInputUpdateState()
        updateCurrentNumber(digit)
    }

    private func updateCurrentNumber(_ digit: Character) {
        if currentState == CalculatorState.firstDigit {
            currentNumber = "0"
        }
        switch digit {
        case "0":
            guard isARightZero() else { break }
            currentNumber = "\(currentNumber)0"
        case ",":
            guard currentNumber.noDecimalYet() else { break }
            currentNumber = "\(currentNumber)."
        default:
            if currentNumber != "0" {
                currentNumber = "\(currentNumber)\(digit)"
            } else {
                currentNumber = "\(digit)"
            }
        }
    }

    private func digitInputUpdateState() {
        switch currentState {
        case .allClear, .justCleared:
            currentState = .firstDigit
        case .mathOperator:
            currentState = .firstDigit
        case .firstDigit:
            currentState = .otherDigits
        default:
            break
        }
    }

    private func shouldPersistCurrentTerm() -> Bool {
        if currentState != .allClear {
            return true
        }
        return false
    }

    private func operationTypeChanged(_ mathOperation1: MathOperator, _ mathOperation2: MathOperator) -> Bool {
        switch (mathOperation1, mathOperation2) {
        case (MathOperator.plus, MathOperator.plus),
            (MathOperator.plus, MathOperator.minus),
            (MathOperator.minus, MathOperator.plus),
            (MathOperator.minus, MathOperator.minus):
            return false
        case (MathOperator.multiplication, MathOperator.multiplication),
            (MathOperator.multiplication, MathOperator.division),
            (MathOperator.division, MathOperator.multiplication),
            (MathOperator.division, MathOperator.division):
            return false
        default:
            return true
        }
    }

    private func isSameOperatorType() -> Bool {
        if let previousOp = previousMathOperator, let currentOp = currentMathOperator {
            if operationTypeChanged(previousOp, currentOp) {
                return false
            }
            return true
        }
        return false
    }
}

// MARK: Operation (+,-,*,/) Input

extension MathOperation {
    public func operatorInput(_ input: Character) throws {
        assert(input.isValidOperatorInput)
        guard input.isValidOperatorInput else {
            throw MathOperation.Error.invalidInput(input)
        }
        currentMathOperator = try getMathOperator(from: input)
        if currentState != .allClear {
            currentState = .mathOperator
        }
        if shouldPersistCurrentTerm() {
            if isSameOperatorType() {
                if let previousOp = previousMathOperator?.rawValue {
                    currentTerm.append("\(currentNumber) \(previousOp)")
                }
            }
        }
    }

    // MARK: Helper functions

    private func getMathOperator(from char: Character) throws -> MathOperator {
        var rawValue = char
        if rawValue == "÷" {
            rawValue = "/"
        } else {
            if rawValue == "X" {
                rawValue = "*"
            }
        }
        assert(MathOperator.init(rawValue: rawValue) != nil)
        guard let mathOperator = MathOperator.init(rawValue: rawValue) else {
            throw MathOperation.Error.invalidInput(char)
        }
        return mathOperator
    }
}
