//
//  NBATradeMachineApp.swift
//  NBATradeMachine
//
//  Created by Shawn Vazin on 5/1/26.
//


import SwiftUI

import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,

                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true

  }

}


@main

struct NBATradeMachineApp: App {

  // register app delegate for Firebase setup

  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {

    WindowGroup {

      NavigationView {

        ContentView()

      }

    }

  }

}
