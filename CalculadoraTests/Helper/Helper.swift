//
//  Helperswift.swift
//  CalculadoraTests
//
//  Created by Fernando Goulart on 12/10/21.
//

import XCTest
import Calculadora

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
