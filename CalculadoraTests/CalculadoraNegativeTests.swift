//
//  CalculadoraNegativeTests.swift
//  CalculadoraTests
//
//  Created by Fernando Goulart on 12/10/21.
//

import Calculadora
import XCTest

class CalculadoraNegativeTests: XCTestCase {

    // MARK: Initialization tests

    func test_init_clearShouldNotThrow() {
        let sut = makeSUT()
        XCTAssertNoThrow(sut.negativeInput())
    }

    // MARK: Left Side Negative

    func test_negative_shouldMakeLeftSideNegative() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        sut.negativeInput()
        XCTAssertEqual(sut.display, "-34")
        sut.negativeInput()
        XCTAssertEqual(sut.display, "34")
        try! sut.operatorInput("+")
        sut.negativeInput()
        XCTAssertEqual(sut.display, "34")
        // swiftlint:enable force_try
    }

    func test_negative_zeroInput() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("0")
        try! sut.operatorInput("-")
        try! sut.digitInput("0")
        sut.negativeInput()
        XCTAssertEqual(sut.display, "-0")
        sut.equalsInput()
        XCTAssertEqual(sut.display, "0")
    }
}
