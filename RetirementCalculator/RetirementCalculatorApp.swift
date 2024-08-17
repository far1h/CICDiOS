//
//  RetirementCalculatorApp.swift
//  RetirementCalculator
//
//  Created by Farih Muhammad on 17/08/2024.
//

import SwiftUI
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@main
struct RetirementCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          AppCenter.start(withAppSecret: "98117ad6-a419-4ab2-94a7-e3821af9f9fe", services:[
            Crashes.self, Analytics.self])
        return true
    }
}
