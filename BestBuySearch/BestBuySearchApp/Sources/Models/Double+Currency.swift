//
//  Double+Currency.swift
//  Models
//

import Foundation

extension Double {
    public func toCurrencyString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
