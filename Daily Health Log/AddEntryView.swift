//
//  AddEntryView.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
//creates a new screen where users input data (form where users create a new health entry)
//"Let the user enter health data, convert it into a HealthEntry, save it, and return to the main screen"

import SwiftUI
import SwiftData

// defining the screen where the user adds a new health entry
struct AddEntryView: View {
    
    // gives this view access to the SwiftData model context
    // modelContext lets us insert new saved data
    @Environment(\.modelContext) var context
    
    // dismiss lets this sheet close itself after saving or cancelling
    @Environment(\.dismiss) var dismiss
    
    // @Query fetches all saved HealthEntry objects
    // we use this to check whether an entry for the selected day already exists
    @Query(sort: \HealthEntry.date, order: .reverse) var entries: [HealthEntry]
    
    // @State stores temporary form input for this screen
    @State private var selectedDate = Date()
    @State private var sleepHours = ""
    @State private var heartRate = ""
    @State private var energyLevel = 3
    @State private var notes = ""
    
    // state for showing duplicate-entry alert
    @State private var showDuplicateAlert = false
    
    // UI layout of the add-entry form
    var body: some View {
        NavigationStack {
            Form {
                
                // section for the date of the entry
                // displayedComponents: .date means user picks only month/day/year
                Section("Date") {
                    DatePicker("Entry Date", selection: $selectedDate, displayedComponents: .date)
                }
                
                // section for the main health inputs
                Section("Health Details") {
                    
                    // text field for sleep hours
                    TextField("Hours of Sleep", text: $sleepHours)
                        .keyboardType(.decimalPad)
                    
                    // text field for resting heart rate in the morning
                    // placeholder text explains what kind of heart rate the user should enter
                    TextField("Resting Heart Rate (morning)", text: $heartRate)
                        .keyboardType(.numberPad)
                    
                    // stepper lets the user choose energy from 1 to 5
                    Stepper("Energy Level: \(energyLevel)/5", value: $energyLevel, in: 1...5)
                }
                
                // section for optional notes
                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            
            // sets the top title of the form screen
            .navigationTitle("Add Entry")
            
            // adds navigation bar buttons
            .toolbar {
                
                // cancel button closes the sheet without saving
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                // save button validates input and saves a new entry
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(!formIsValid)
                }
            }
            
            // alert appears if the user tries to save a second entry for the same day
            .alert("Entry Already Exists", isPresented: $showDuplicateAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("You already have an entry for this day. Please choose a different date.")
            }
        }
    }
    
    // computed property checks whether the required fields are valid
    // save stays disabled until the user enters usable values
    var formIsValid: Bool {
        guard let sleep = Double(sleepHours), sleep >= 0 else { return false }
        guard let hr = Int(heartRate), hr > 0 else { return false }
        return true
    }
    
    // helper checks whether an entry already exists on the same calendar day
    // both dates are normalized to the start of the day before comparing
    func entryExists(for date: Date) -> Bool {
        let selectedDay = Calendar.current.startOfDay(for: date)
        
        return entries.contains { entry in
            let entryDay = Calendar.current.startOfDay(for: entry.date)
            return entryDay == selectedDay
        }
    }
    
    // save function converts the form input into a HealthEntry and stores it in SwiftData
    func saveEntry() {
        guard let sleep = Double(sleepHours),
              let hr = Int(heartRate) else {
            return
        }
        
        // normalize the date to the start of the selected day
        // this keeps saved dates consistent and removes time-of-day variation
        let normalizedDate = Calendar.current.startOfDay(for: selectedDate)
        
        // block duplicate entries for the same calendar day
        if entryExists(for: normalizedDate) {
            showDuplicateAlert = true
            return
        }
        
        let newEntry = HealthEntry(
            date: normalizedDate,
            sleepHours: sleep,
            heartRate: hr,
            energyLevel: energyLevel,
            notes: notes
        )
        
        // inserts the new entry into SwiftData storage
        context.insert(newEntry)
        
        // closes the sheet after saving
        dismiss()
    }
}

#Preview {
    AddEntryView()
}
