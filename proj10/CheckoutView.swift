//
//  CheckoutView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var checkoutfail = false

    

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .alert(checkoutfail ? "Opps..." : "Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        

    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            checkoutfail = false

        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            confirmationMessage = "Checkout failed: \(error.localizedDescription)"
            checkoutfail = true
        }
        showingConfirmation = true

        
    }
}

#Preview {
    CheckoutView(order: Order())
}
