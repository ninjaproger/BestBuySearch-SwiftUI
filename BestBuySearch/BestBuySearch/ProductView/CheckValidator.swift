//
//  CheckValidator.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

protocol CheckValidatorType: ObservableObject {
    static func isValid(code: String) -> Bool
}

final class CheckValidator: CheckValidatorType {
    static func isValid(code: String) -> Bool {
        guard code.count == 12  else {
            return false
        }
        let numbers = code.compactMap { Int(String($0)) } // Convert code string to list of integers
        let sum = numbers
            .reversed() // Go from right to left
            .enumerated()
            .map { offset, element -> Int in
                if offset % 2 != 0 { // Multiply odd numbers by 3
                    return element * 3
                } else if offset != 0 { // Skip the last digit of the code
                    return element
                }
                return 0
            }
            .reduce(0, +)

        let reminder = sum % 10

        // If no reminder the code is equal to zero
        let result: Int = reminder > 0 ? 10 - reminder : 0
        return result == numbers.last
    }
}
