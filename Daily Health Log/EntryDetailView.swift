//
//  EntryDetailView.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
//Make each entry tappable so the user can open a dedicated screen, detail screen = one entry in full view
//wrap each row (date, sleep hours, heart rate, energy level, notes) in a NavigationLink from ContentView

import SwiftUI

//new screen
struct EntryDetailView: View {
    //This passes one specific log entry into the detail screen
    let entry: HealthEntry

    var body: some View {
        //Creates a clean scrollable layout for showing all the entry data
        List {
            //Organizes the information into readable groups
            
            // Overview section shows the date for this entry
            Section("Overview") {
                HStack { // this places label on the left, value on the right
                    Text("Date")
                    Spacer()
                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                        .foregroundStyle(.secondary) //makes the value text a softer gray tone
                }
            }

            // Health Metrics section groups the main numeric health data
            Section("Health Metrics") {
                HStack {
                    Text("Sleep")
                    Spacer()
                    Text("\(entry.sleepHours, specifier: "%.1f") hours")
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("Resting Heart Rate (Morning)")
                    Spacer()
                    Text("\(entry.heartRate) bpm")
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("Energy Level")
                    Spacer()
                    Text("\(entry.energyLevel)/5")
                        .foregroundStyle(.secondary)
                }
            }

            // Notes section shows any written notes from the user
            Section("Notes") {
                
                // if no notes were added, show placeholder text
                if entry.notes.isEmpty {
                    Text("No notes added")
                        .foregroundStyle(.secondary)
                } else {
                    Text(entry.notes)
                }
            }
        }
        //Sets the title at the top of the detail screen
        .navigationTitle("Entry Details")
        //Keeps the title compact and polished
        .navigationBarTitleDisplayMode(.inline)
    }
}

