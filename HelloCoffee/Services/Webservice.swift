//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 12/1/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
}

class Webservice {
    
    private var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from : url)
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                throw NetworkError.badRequest
        }
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        return orders
    }
    
    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data, responce) = try await URLSession.shared.data(for: request)
        
        guard let httpResponce = responce as? HTTPURLResponse,
                httpResponce.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        return newOrder
    }
    
    func deleteOrder(orderId: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, responce) = try await URLSession.shared.data(for: request)
        guard let httpResponce = responce as? HTTPURLResponse,
              httpResponce.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return deletedOrder
    }
}
