//
//  Operation.swift
//  Calculadora
//
//  Created by Fernando Goulart on 10/10/21.
//

import Foundation

public enum MathOperator: String {
    case plus = "+"
    case minus = "-"
    case division = "/"
    case multiplication = "*"
}

public final class MathOperation {
    public var display: String = "0"
    public var currentMathOperator: MathOperator? = MathOperator.plus
    public var expression: String = ""
    public var currentTerm: Array<String> = ["0"]
    
    public init() { }
    
    public func addNumber(digit: String) {
        
    }
}
