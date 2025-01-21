//
//  Untitled.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 19/1/25.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        switch value {
        case true:
            self
        case false:
            EmptyView()
        }
    }
}
