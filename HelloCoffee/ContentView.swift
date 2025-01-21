//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 12/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    @State private var isPresented: Bool = false
    
    private func getOrders() async {
        do {
            try await model.getOrders()
        } catch {
            print("fail to get order")
        }
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List(model.orders) { order in
                        OrderCellView(order: order)
                    }
                }
            }
            .task {
                print("getOrders")
                await getOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

#Preview {
    var config = Configuration()
    ContentView()
        .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}


