//
//  ButtonType.swift
//  calculator
//
//  Created by TumbaDev on 17.07.24.
//

import SwiftUI


enum MathematicalOperation: String  {
    case div = "÷"
    case mul = "×"
    case sub = "-"
    case add = "+"
    case equal = "="
}

enum CalculatorControl: String {
    case clear = "AC"
    case negate = "±"
    case percent = "%"
    case decimal = "."
}

enum ButtonType: Hashable {
    case digit(Int)
    case operation(MathematicalOperation)
    case control(CalculatorControl)
    
    var color: Color {
        switch self {
        case .digit:
            Color(.darkGray)
        case .operation:
            .orange
        case .control(let control):
            if control == .decimal {
                Color(.darkGray)
            } else {
                Color(.lightGray)
            }
        }
    }
    

    
    var textColor: Color {
        switch self {
        case .control(let control):
            if control == .decimal {
                .white
            } else {
                .black
            }
        default:
                .white
        }
    }
    
    var title: String {
        switch self {
        case .digit(let digit):
            "\(digit)"
        case .control(let control):
            control.rawValue
        case .operation(let operation):
            operation.rawValue
        }
    }
    
    var isWide: Bool {
        switch self {
        case .digit(let digit) where digit == 0:
            true
        default:
            false
        }
    }
}

