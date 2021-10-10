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
        XCTAssertEqual(mOperation.display , "0")
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

    private func makeSut() -> MathOperation {
        return MathOperation()
    }
}
