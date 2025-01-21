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
        print(orders)
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId : Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
        orders = orders.filter { $0.id != deletedOrder.id }
    }
    
}
