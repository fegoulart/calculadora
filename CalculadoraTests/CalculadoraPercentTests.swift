//
//  CalculadoraPercentTests.swift
//  CalculadoraTests
//
//  Created by Fernando Goulart on 12/10/21.
//

import XCTest

class CalculadoraPercentTests: XCTestCase {

    // MARK: Initialization tests

    func test_init_percentShouldNotThrow() {
        let sut = makeSUT()
        XCTAssertNoThrow(sut.percentInput())
    }

    // MARK: Left Side Percent

    func test_percent_shouldMakeLeftSide() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        sut.percentInput()
        XCTAssertEqual(sut.display, "0,34")
        // swiftlint:enable force_try
    }

    func test_percent_shouldMakeRightSideNegative() {
        let sut = makeSUT()
        // swiftlint:disable force_try
        try! sut.digitInput("3")
        try! sut.digitInput("4")
        try! sut.operatorInput("+")
        try! sut.digitInput("1")
        try! sut.digitInput("0")
        try! sut.digitInput("0")
        sut.percentInput()
        XCTAssertEqual(sut.display, "1")
        // swiftlint:enable force_try
    }
}
