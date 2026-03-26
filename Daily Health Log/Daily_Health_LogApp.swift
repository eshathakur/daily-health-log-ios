//
//  Daily_Health_LogApp.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
//enable SwiftData storage
//This file defines entire app entry point
//“Start the app, show ContentView, and enable saving and retrieving HealthEntry data using SwiftData.”

import SwiftUI
import SwiftData

@main

//this is the main app file, this is where the app starts running (the root)
struct HealthTrackerApp: App {
    
//    a scene = a UI container (like a window), IOS apps usually ahve 1 main scene
//    this defines the apps structure
    var body: some Scene {
        // WindowGroup = the main container for the app’s UI
        // This is what actually displays the app on screen
        
        //this is the main app window, this launches the UI, tells swift "Show ContentView when the app opens"
        WindowGroup {
            ContentView() // first screen the user sees
        }
        
        // .modelContainer enables SwiftData for the app
        // It tells Swift:
        // "Store and manage HealthEntry objects in a database"
        // it tells SwiftData:
        // "Create a database for HealthEntry objects and make it available throughout the app."
        
        //without this the app would reset every time
        //now: data is stored, can query entries, can insert/delete
        .modelContainer(for: HealthEntry.self)
    }
}


// orginal starter template
//struct Daily_Health_LogApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}
