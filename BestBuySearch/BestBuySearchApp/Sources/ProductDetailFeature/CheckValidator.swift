//
//  CheckValidator.swift
//  ProductDetailFeature
//

import Foundation

public enum CheckValidator {
    public static func isValid(code: String) -> Bool {
        guard code.count == 12 else {
            return false
        }
        let numbers = code.compactMap { Int(String($0)) }
        guard numbers.count == 12 else { return false }
        
        var sum = 0
        for i in 0..<11 {
            let digit = numbers[i]
            if i % 2 == 0 {
                sum += digit * 3
            } else {
                sum += digit
            }
        }
        
        let mod = sum % 10
        let checkDigit = mod == 0 ? 0 : 10 - mod
        return checkDigit == numbers.last
    }
}
