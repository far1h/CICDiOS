//
//  ContentView.swift
//  RetirementCalculator
//
//  Created by Farih Muhammad on 17/08/2024.
//

import SwiftUI
import AppCenterCrashes
import AppCenterAnalytics

struct ContentView: View {
    @State private var monthlyInvestments = ""
    @State private var currentAge = ""
    @State private var retireAge = ""
    @State private var interestRate = ""
    @State private var currentSavings = ""
    @State private var showAlert = false // Added state to manage alert presentation
    
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Monthly Investments", text: $monthlyInvestments)                .textFieldStyle(.roundedBorder)
            
            TextField("Your current age", text: $currentAge)                .textFieldStyle(.roundedBorder)
            
            TextField("Your planned retirement age", text: $retireAge)                .textFieldStyle(.roundedBorder)
            
            TextField("Average interest rate of investments", text: $interestRate)
                .textFieldStyle(.roundedBorder)
            
            TextField("Current savings", text: $currentSavings)
                .textFieldStyle(.roundedBorder)
            Button {
                //                Crashes.generateTestCrash()
                
                let properties = ["current_age": currentAge,
                                  "planned_retirement_age": retireAge]
                Analytics.trackEvent("calculate_retirement_amount", withProperties: properties)
            } label: {
                Spacer()
                Text(
                    "Calculate retirement amount"
                )
                Spacer()
            }.buttonStyle(.borderedProminent)
            Text("Enter some values to calculate your retirement amount")
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) { // Used the new state to trigger the alert
            Alert(title: Text("Oops"),
                  message: Text("Sorry about that, an error occurred."),
                  dismissButton: .default(Text("It's cool")))
        }
        .onAppear {
            Analytics.trackEvent("navigater_to_calculator")
            
            if Crashes.hasCrashedInLastSession {
                showAlert = true // Set the alert to be shown if there was a crash
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
