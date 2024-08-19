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
    // MARK: - PROPERTIES
    
    @State private var monthlyInvestments = ""
    @State private var currentAge = ""
    @State private var retireAge = ""
    @State private var interestRate = ""
    @State private var currentSavings = ""
    @State private var result = "Enter some values to calculate your retirement amount"
    @State private var showAlert = false // Added state to manage alert presentation
    
    // MARK: - FUNCTIONS
    func calculateRetirementAmount(current_age: Int, retirement_age : Int, monthly_investment: Float, current_savings: Float, interest_rate: Float) -> Double {
             let months_until_retirement = (retirement_age - current_age) * 12

             var retirement_amount = Double(current_savings) * pow(Double(1+interest_rate/100), Double(months_until_retirement))

             for i in 1...months_until_retirement {
                 let monthly_rate = interest_rate / 100 / 12
                 retirement_amount += Double(monthly_investment) * pow(Double(1+monthly_rate), Double(i))
             }

             return retirement_amount
         }
    // MARK: - BODY
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Monthly Investments", text: $monthlyInvestments)                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            TextField("Your current age", text: $currentAge)                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            TextField("Your planned retirement age", text: $retireAge)                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            TextField("Average interest rate of investments", text: $interestRate)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            TextField("Current savings", text: $currentSavings)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            Button {
                //                Crashes.generateTestCrash()
                
                let retirement_amount = calculateRetirementAmount(current_age: Int(currentAge) ?? 0, retirement_age: Int(retireAge) ?? 0, monthly_investment: Float(monthlyInvestments) ?? 0, current_savings: Float(currentSavings) ?? 0, interest_rate: Float(interestRate) ?? 0)
                result = "If you save $\(Double(monthlyInvestments)!) every month for \(Int(retireAge)! - Int(currentAge)!) years, and invest that money plus your current investment of $\(Double(currentSavings)!) at a \(Double(interestRate)!)% anual interest rate, you will have $\(retirement_amount.rounded()) by the time you are \(Int(retireAge)!)"
                
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
            Text(result).accessibility(identifier: "resultLabel")
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

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
