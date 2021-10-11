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
    public var currentTerm: [String] = ["0"]
    public private(set) var currentState = CalculatorState.allClear
    private let displayLimit: Int

    public enum Error: Swift.Error {
        case invalidInput(Character)
    }

    public var display: String {
        return currentNumber.toCalculatorDisplay
    }

    public var previousMathOperator: MathOperator? {
        if currentTermHasOperator() {
            guard let previousOperator: Character = getPreviousOperator() else { return nil }
            guard let mOperator = MathOperator.init(rawValue: previousOperator ) else { return nil }
                return mOperator
        } else {
            return nil
        }
    }

    public init(displayLimit: Int = 9) {
        self.displayLimit = displayLimit
    }

    public func digitInput(_ digit: Character) throws {
        guard digit.isValidCalculatorDigit() else { throw MathOperation.Error.invalidInput(digit) }
        guard currentNumber.onlyNumbers.count < displayLimit else { return }
        digitInputUpdateState()
        updateCurrentNumber(digit)
    }

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

    // MARK: Helper functions

    private func currentTermHasOperator() -> Bool {
        return currentTerm.count > 1
    }

    private func isARightZero() -> Bool {
        guard currentNumber.count > 0 else { return true }
        return currentNumber != "0"
    }

    private func getPreviousOperator() -> Character? {
        var previousOperator: Character?
        for index in currentTerm.lastIndex...0 {
            let value = currentTerm[index]
            if value == "+" || value == "-" || value == "/" || value == "*" {
                previousOperator = Character(value)
                break
            }
        }
        return previousOperator
    }
}
