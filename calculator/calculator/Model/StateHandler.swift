//
//  StateHandler.swift
//  calculator
//
//  Created by TumbaDev on 17.07.24.
//

import SwiftUI

class StateHandler: ObservableObject {
    @Published var display: String = "0"
    private var currentNumber: String = "0"
    private var previousNumber: String = "0"
    private var operation: MathematicalOperation?
    private var isNumberEntered: Bool = false
    private var hasDecimal: Bool = false

    func Handle(button: ButtonType) {
        switch button {
        case .digit(let number):
            handleDigit(number)
        case .operation(let op):
            handleOperation(op)
        case .control(let control):
            handleControl(control)
        }
    }

    private func handleDigit(_ number: Int) {
        if display == "0" || !isNumberEntered {
            display = "\(number)"
        } else {
            display += "\(number)"
        }
        currentNumber = display
        isNumberEntered = true
    }

    private func handleOperation(_ sign: MathematicalOperation) {
        if isNumberEntered {
            if let currentOperation = operation, sign == .equal {
                performOperation(currentOperation)
            } else {
                previousNumber = currentNumber
            }
            operation = sign
            isNumberEntered = false
            hasDecimal = false 
        } else {
            operation = sign
            if sign == .sub && display == "0" {
                display = "-"
                currentNumber = display
                isNumberEntered = true
            }
        }
    }

    private func performOperation(_ sign: MathematicalOperation) {
        var curr = currentNumber
        if curr.hasSuffix("%") {
            curr.removeLast()
            if let value = Double(curr) {
                curr = String(value / 100)
            }
        }

        guard let prev = Double(previousNumber), let currValue = Double(curr) else {
            return
        }

        var result: Double = 0

        switch sign {
        case .add:
            result = prev + currValue
        case .sub:
            result = prev - currValue
        case .mul:
            result = prev * currValue
        case .div:
            if currValue != 0 {
                result = prev / currValue
            } else {
                display = "Error"
                return
            }
        case .equal:
            result = currValue
        }

        previousNumber = formatResult(result)
        currentNumber = previousNumber
        display = previousNumber
    }

    private func handleControl(_ control: CalculatorControl) {
        switch control {
        case .clear:
            display = "0"
            currentNumber = "0"
            previousNumber = "0"
            operation = nil
            isNumberEntered = false
            hasDecimal = false
        case .negate:
            if display != "0" {
                if display.hasPrefix("-") {
                    display.removeFirst()
                } else {
                    display = "-" + display
                }
                currentNumber = display
            }
        case .percent:
            if !currentNumber.isEmpty && !currentNumber.hasSuffix("%") {
                display += "%"
                currentNumber = display
                isNumberEntered = true
            }
        case .decimal:
            if !hasDecimal {
                display += "."
                currentNumber = display
                hasDecimal = true
                isNumberEntered = true
            }
        }
    }

    private func formatResult(_ result: Double) -> String {
        let resultString = String(result)
        if resultString.hasSuffix(".0") {
            return String(resultString.dropLast(2))
        }
        return resultString
    }
}
