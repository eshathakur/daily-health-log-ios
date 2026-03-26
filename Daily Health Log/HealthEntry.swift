//
//  HealthEntry.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
//database structure, defines the data model
//"What does one health log entry look like?"

//Each HealthEntry = one row in the app’s database

import Foundation   // gives access to basic types like Date
import SwiftData    // Apple’s framework for saving data (like a database)

// @Model tells SwiftData:
// "This class should be stored in the database"/“Save objects of this class into a database”
//otherwise nothing gets stores & lose data when app closes
@Model
//defines a blueprint, everytime a user logs their health, create one of these:
class HealthEntry {
    
    // MARK: - Properties (what data each entry stores), variables inside the class
//    5 fields in this database
    
    var date: Date           // when the entry was created
    var sleepHours: Double
    var heartRate: Int       // in beats per minute
    var energyLevel: Int     // rating 1–5
    var notes: String        // optional notes from user
    
    // MARK: - Initializer
//    intit(...) how you create a new entry
//    Ex) let entry = HealthEntry(...)
    
    init(date: Date, sleepHours: Double, heartRate: Int, energyLevel: Int, notes: String) {
//        assign input value --> to the stored property
        self.date = date
        self.sleepHours = sleepHours
        self.heartRate = heartRate
        self.energyLevel = energyLevel
        self.notes = notes
    }
}


