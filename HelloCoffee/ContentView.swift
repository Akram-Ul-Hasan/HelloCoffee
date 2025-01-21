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
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            
            guard let orderId = order.id else {
                return
            }
            
            Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders){ order in
                            OrderCellView(order: order)
                        }
                        .onDelete(perform: deleteOrder)
                    }
                }
            }
            .task {
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


