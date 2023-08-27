//
//  ViewModel.swift
//  iOS_Calculator
//
//  Created by Salva Moreno on 5/8/23.
//

import Foundation

final class ViewModel: ObservableObject {
    
    @Published var textFieldValue: String = "0"
    
    var textFieldSavedValue: String = "0"
    var currentOperationToExecute: OperationType?
    var shouldRunOperation: Bool = false
    
    func logic(key: KeyboardButton) {
        
        switch key.type {
        case .number(let value):
            if textFieldValue.count != 11 {
                if shouldRunOperation {
                    textFieldValue = "0"
                }
                textFieldValue = textFieldValue == "0" ? "\(value)" : textFieldValue + "\(value)"
                shouldRunOperation = false
            } else if (textFieldValue.count == 11 && shouldRunOperation) {
                textFieldValue = "0"
                textFieldValue = textFieldValue == "0" ? "\(value)" : textFieldValue + "\(value)"
                shouldRunOperation = false
            }
        case .operation(let type):
            textFieldSavedValue = textFieldValue
            currentOperationToExecute = type
            shouldRunOperation = true
        case .result:
            guard let operation = currentOperationToExecute else {
                return
            }
            
            switch operation {
            case .sum:
                textFieldValue = sum(textFieldSavedValue, textFieldValue)
            case .multiplication:
                textFieldValue = multiplication(textFieldSavedValue, textFieldValue)
            case .subtract:
                textFieldValue = subtract(textFieldSavedValue, textFieldValue)
            case .division:
                textFieldValue = division(textFieldSavedValue, textFieldValue)
            }
        case .reset:
            textFieldValue = "0"
            textFieldSavedValue = "0"
            currentOperationToExecute = nil
            shouldRunOperation = false
        case .decimal:
            textFieldValue = textFieldValue + "."
        case .transformSign:
            textFieldValue = textFieldValue.contains("-") ? textFieldValue.replacingOccurrences(of: "-", with: "") : "-" + textFieldValue
        case .divideBy100:
            if textFieldValue.count <= 10 {
                if (textFieldValue.contains(".") && textFieldValue.contains("-")) {
                    textFieldValue = textFieldValue.replacingOccurrences(of: ".", with: "")
                    textFieldValue = textFieldValue.replacingOccurrences(of: "-", with: "")
                    textFieldValue = "-0.0" + textFieldValue
                } else if textFieldValue.contains(".") {
                    textFieldValue = textFieldValue.replacingOccurrences(of: ".", with: "")
                    textFieldValue = "0.0" + textFieldValue
                } else {
                    textFieldValue = "\(Double(textFieldValue)! / 100)"
                }
            }
            
        }
        
        func sum(_ textFieldSavedValue: String, _ textFieldValue: String) -> String {
            let result: Double = round(10000 * (Double(textFieldSavedValue)! + Double(textFieldValue)!)) / 10000
            return "\(result)".hasSuffix(".0") ? "\(result)".replacingOccurrences(of: ".0", with: "") : "\(result)"
        }
        
        func multiplication(_ textFieldSavedValue: String, _ textFieldValue: String) -> String {
            let result: Double = round(10000 * (Double(textFieldSavedValue)! * Double(textFieldValue)!)) / 10000
            return "\(result)".hasSuffix(".0") ? "\(result)".replacingOccurrences(of: ".0", with: "") : "\(result)"
        }
        
        func subtract(_ textFieldSavedValue: String, _ textFieldValue: String) -> String {
            let result: Double = round(10000 * (Double(textFieldSavedValue)! - Double(textFieldValue)!)) / 10000
            return "\(result)".hasSuffix(".0") ? "\(result)".replacingOccurrences(of: ".0", with: "") : "\(result)"
        }
        
        func division(_ textFieldSavedValue: String, _ textFieldValue: String) -> String {
            let result: Double = round(10000 * (Double(textFieldSavedValue)! / Double(textFieldValue)!)) / 10000
            return "\(result)".hasSuffix(".0") ? "\(result)".replacingOccurrences(of: ".0", with: "") : "\(result)"
        }
        
    }
    
}
