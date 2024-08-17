//
//  ContentView.swift
//  RetirementCalculator
//
//  Created by Farih Muhammad on 17/08/2024.
//

import SwiftUI
import AppCenterCrashes

struct ContentView: View {
    @State private var monthlyInvestments = ""
    @State private var currentAge = ""
    @State private var retireAge = ""
    @State private var interestRate = ""
    @State private var currentSavings = ""
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
