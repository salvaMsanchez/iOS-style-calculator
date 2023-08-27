//
//  Model.swift
//  iOS_Calculator
//
//  Created by Salva Moreno on 5/8/23.
//

import Foundation
import SwiftUI

struct KeyboardButton: Hashable {
    let title: String
    let textColor: Color
    let backgroundColor: Color
    let isDoubleWith: Bool
    let type: ButtonType
}

enum ButtonType: Hashable {
    case number(Int)
    case operation(OperationType)
    case reset
    case result
    case decimal
    case transformSign
    case divideBy100
}

enum OperationType: Hashable {
    case sum
    case multiplication
    case subtract
    case division
}
