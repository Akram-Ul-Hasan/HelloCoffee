//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 12/1/25.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    
    @Published private(set) var orders = [Order]()
    
    let webservice : Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func getOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
}
