//
//  CalculadoraTests.swift
//  CalculadoraTests
//
//  Created by Fernando Goulart on 10/10/21.
//

import XCTest
import Calculadora

class AdditionSubtractionUseStoryTests: XCTestCase {

    // MARK: SUT Initialization

    func test_init_operationMustInitializeWithValueZero() {
        let mOperation = makeSut()
        XCTAssertEqual(mOperation.display, "0")
    }

    func test_init_operationMustInitializeWithPlusOperator() {
        let mOperation = makeSut()
        XCTAssertEqual(mOperation.currentMathOperator, MathOperator.plus)
    }

    func test_init_operationExpressionMustBeEmpty() {
        let mOperation = makeSut()
        XCTAssertEqual(mOperation.expression, "")
    }

    func test_init_checkOperationCurrentTermArray() {
        let mOperation = makeSut()
        XCTAssertEqual(mOperation.currentTerm, ["0"])
    }

    func test_init_stateMustBeMathOperator() {
        let mOperation = makeSut()
        XCTAssertEqual(mOperation.currentState, CalculatorState.mathOperator)
    }

    // MARK: Digit input

    func test_input_mustThrowForInvalidDigit() {
        let mOperation = makeSut()
        XCTAssertThrowsError(try mOperation.digitInput("A"))
    }

    func test_input_mustNotThrowForValidDigit() {
        let mOperation = makeSut()
        XCTAssertNoThrow(try mOperation.digitInput("0"))
        XCTAssertNoThrow(try mOperation.digitInput("1"))
        XCTAssertNoThrow(try mOperation.digitInput("2"))
        XCTAssertNoThrow(try mOperation.digitInput("3"))
        XCTAssertNoThrow(try mOperation.digitInput("4"))
        XCTAssertNoThrow(try mOperation.digitInput("5"))
        XCTAssertNoThrow(try mOperation.digitInput("6"))
        XCTAssertNoThrow(try mOperation.digitInput("7"))
        XCTAssertNoThrow(try mOperation.digitInput("8"))
        XCTAssertNoThrow(try mOperation.digitInput("9"))
        XCTAssertNoThrow(try mOperation.digitInput(","))
    }

    func test_input_stateMustChangeOnSecondInput() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("1")
        try! mOperation.digitInput("2")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.currentState, CalculatorState.otherDigits)
    }

    func test_input_dontDisplayLeftZerosOnZerosInput() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "0")
    }

    func test_input_dontDisplayLeftZeros() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput("2")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "12")
    }

    func test_input_displayRightZeros() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("2")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "102")
    }

    func test_input_displayShouldTruncateOnLimit() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("2")
        try! mOperation.digitInput("3")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("2")
        try! mOperation.digitInput("4")
        try! mOperation.digitInput("2")
        try! mOperation.digitInput("3")
        try! mOperation.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "102.302.423")
        XCTAssertEqual(mOperation.currentNumber, "102302423")
    }

    func test_input_decimalZeroInteger() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput(",")
        XCTAssertEqual(mOperation.display, "0,")
        XCTAssertEqual(mOperation.currentNumber, "0.")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput("2")
        try! mOperation.digitInput("3")
        try! mOperation.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "0,1239")
        XCTAssertEqual(mOperation.currentNumber, "0.1239")
    }

    func test_input_decimal() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput(",")
        try! mOperation.digitInput("2")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "1,2")
        XCTAssertEqual(mOperation.currentNumber, "1.2")
    }

    func test_input_decimalRepetition() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("1")
        try! mOperation.digitInput(",")
        try! mOperation.digitInput("2")
        try! mOperation.digitInput(",")
        try! mOperation.digitInput(",")
        try! mOperation.digitInput("3")
        try! mOperation.digitInput("4")
        try! mOperation.digitInput(",")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "1,234")
        XCTAssertEqual(mOperation.currentNumber, "1.234")
    }

    func test_input_thousandSeparator() {
        let mOperation = makeSut()
        // swiftlint:disable force_try
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("0")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        try! mOperation.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(mOperation.display, "999.999.999")
        XCTAssertEqual(mOperation.currentNumber, "999999999")
    }

    // MARK: Operator input

    // MARK: Helper Methods

    private func makeSut(displayLimit: Int = 9) -> MathOperation {
        return MathOperation(displayLimit: displayLimit)
    }
}
