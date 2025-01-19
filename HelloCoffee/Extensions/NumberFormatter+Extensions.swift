//
//  NumberFormatter+Extensions.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 12/1/25.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
