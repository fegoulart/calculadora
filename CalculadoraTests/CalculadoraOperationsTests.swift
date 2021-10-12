//
//  CalculadoraTests.swift
//  CalculadoraTests
//
//  Created by Fernando Goulart on 12/10/21.
//

import XCTest
import Calculadora

class CalculadoraOperationsTests: XCTestCase {

    // MARK: Initialization tests

    func test_init_nilExpression() {
        let allNilExpression = SimpleExpression(
            leftTerm: nil,
            rightTerm: nil,
            mathOperator: nil)
        let sut = makeSUT()
        XCTAssertEqual(sut.expression, allNilExpression)
    }

    func test_init_shouldDisplayZero() {
        let sut = makeSUT()
        XCTAssertEqual(sut.display, "0")
    }

    // MARK: Helper methods

    func makeSUT(
        limit: Int = 9,
        expression: SimpleExpression = SimpleExpression()
    ) -> MathOperation {
        return MathOperation(
            displayLimit: limit,
            expression: expression
        )
    }
}

// MARK: Digit input

extension CalculadoraOperationsTests {

    func test_input_invalidDigitShouldThrow() {
        let sut = makeSUT()
        XCTAssertThrowsError(try sut.digitInput("A"))
    }

    func test_input_validDigitShouldDisplay() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("5")
        XCTAssertEqual(sut.display, "5")
        try! sut.digitInput(",")
        XCTAssertEqual(sut.display, "5,")
        try! sut.digitInput("1")
        XCTAssertEqual(sut.display, "5,1")
        try! sut.digitInput("2")
        XCTAssertEqual(sut.display, "5,12")
        try! sut.digitInput("3")
        XCTAssertEqual(sut.display, "5,123")
        try! sut.digitInput("4")
        XCTAssertEqual(sut.display, "5,1234")
        try! sut.digitInput("5")
        XCTAssertEqual(sut.display, "5,12345")
        try! sut.digitInput("6")
        XCTAssertEqual(sut.display, "5,123456")
        try! sut.digitInput("7")
        XCTAssertEqual(sut.display, "5,1234567")
        try! sut.digitInput("8")
        XCTAssertEqual(sut.display, "5,12345678")
        // swiftlint:enable force_try
    }

    func test_input_truncateMoreThanLimit() {
        let sut = makeSUT(limit: 9)
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput("7")
        try! sut.digitInput("8")
        try! sut.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "0,12345678")
    }

    func test_input_shouldNotAcceptMoreThanOneDecimal() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.digitInput(",")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput(",")
        try! sut.digitInput("7")
        try! sut.digitInput("8")
        try! sut.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "0,12345678")
    }

    func test_input_shouldAcceptInitialDecimal() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput(",")
        XCTAssertEqual(sut.display, "0,")
        try! sut.digitInput("1")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "0,1")
    }

    func test_input_shouldShowThousandSeparators() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "9.999.999,12")
    }
}

// MARK: Operator input

extension CalculadoraOperationsTests {

    func test_input_shouldThrowOnInvalidOperator() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("2")
        try! sut.digitInput("4")
        try! sut.digitInput("1")
        // swiftlint:enable force_try
        XCTAssertThrowsError(try sut.operatorInput("!"))
    }

    func test_input_shouldShowLeftTermOnOperatorInput() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("2")
        try! sut.digitInput("4")
        try! sut.digitInput("1")
        try! sut.operatorInput("÷")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "241")
    }
}

// MARK: Right Term Input

extension CalculadoraOperationsTests {
    func test_input_invalidDigitShouldThrowForRightTerm() {
        let sut = makeSUT()

        // swiftlint:disable force_try
        try! sut.digitInput("2")
        try! sut.digitInput("4")
        try! sut.digitInput("1")
        try! sut.operatorInput("÷")
        try! sut.digitInput("5")
        // swiftlint: enable force_try
        XCTAssertThrowsError(try sut.digitInput("A"))
    }

    func test_input_validDigitShouldDisplayForRightTerm() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.operatorInput("÷")
        try! sut.digitInput("5")
        XCTAssertEqual(sut.display, "5")
        try! sut.digitInput(",")
        XCTAssertEqual(sut.display, "5,")
        try! sut.digitInput("1")
        XCTAssertEqual(sut.display, "5,1")
        try! sut.digitInput("2")
        XCTAssertEqual(sut.display, "5,12")
        try! sut.digitInput("3")
        XCTAssertEqual(sut.display, "5,123")
        try! sut.digitInput("4")
        XCTAssertEqual(sut.display, "5,1234")
        try! sut.digitInput("5")
        XCTAssertEqual(sut.display, "5,12345")
        try! sut.digitInput("6")
        XCTAssertEqual(sut.display, "5,123456")
        try! sut.digitInput("7")
        XCTAssertEqual(sut.display, "5,1234567")
        try! sut.digitInput("8")
        XCTAssertEqual(sut.display, "5,12345678")
        // swiftlint:enable force_try
    }

    func test_input_truncateMoreThanLimitForRightTerm() {
        let sut = makeSUT(limit: 9)
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.operatorInput("X")
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput("7")
        try! sut.digitInput("8")
        try! sut.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "0,12345678")
    }

    func test_input_shouldNotAcceptMoreThanOneDecimalForRightTerm() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.operatorInput("X")
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.digitInput(",")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput(",")
        try! sut.digitInput("7")
        try! sut.digitInput("8")
        try! sut.digitInput("9")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "0,12345678")
    }

    func test_input_shouldShowThousandSeparatorsForRightTerm() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput("9")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        // swiftlint:enable force_try
        XCTAssertEqual(sut.display, "999.999,123")
    }
}
// MARK: Result test
extension CalculadoraOperationsTests {
    func test_result_shouldShowErrorOnDisplay() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.operatorInput("÷")
        try! sut.digitInput("0")
        // swiftlint:enable force_try
        sut.equalsInput()
        XCTAssertEqual(sut.display, NSLocalizedString("Erro", comment: "Error"))
    }

    func test_result_shouldCalculateMultiplication() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.digitInput(",")
        try! sut.digitInput("1")
        try! sut.digitInput("2")
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.operatorInput("X")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput("9")
        try! sut.digitInput("8")
        try! sut.digitInput("7")
        try! sut.digitInput("5")
        // swiftlint:enable force_try
        sut.equalsInput()
        XCTAssertEqual(sut.display, "70.322,575")
    }

    func test_result_shouldCalculateDivision() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("9")
        try! sut.digitInput("8")
        try! sut.digitInput("7")
        try! sut.digitInput("5")
        try! sut.digitInput("6")
        try! sut.digitInput("4")
        try! sut.operatorInput("÷")
        try! sut.digitInput("6")
        try! sut.digitInput("4")
        // swiftlint:enable force_try
        sut.equalsInput()
        XCTAssertEqual(sut.display, "15.430,6875")
    }

    func test_result_shouldCalculateSum() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("2")
        try! sut.digitInput(",")
        try! sut.digitInput("7")
        try! sut.digitInput("5")
        try! sut.operatorInput("+")
        try! sut.digitInput("6")
        try! sut.digitInput(",")
        try! sut.digitInput("6")
        try! sut.digitInput("4")
        // swiftlint:enable force_try
        sut.equalsInput()
        XCTAssertEqual(sut.display, "9,39")
    }

    func test_result_shouldCalculateSubtraction() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("2")
        try! sut.digitInput(",")
        try! sut.digitInput("7")
        try! sut.digitInput("5")
        try! sut.operatorInput("-")
        try! sut.digitInput("6")
        try! sut.digitInput(",")
        try! sut.digitInput("6")
        try! sut.digitInput("4")
        // swiftlint:enable force_try
        sut.equalsInput()
        XCTAssertEqual(sut.display, "-3,89")
    }
}
