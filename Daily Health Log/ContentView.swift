    //
//  ContentView.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
//

//screen now shows a dynamic list of saved entries, it has the power to save/delete data
//has a health dashboard with averahe sleep & heart rate and total entries logged

//NavigationStack manages moving between screens
//NavigationLink triggers the move
//EntryDetailView is the destination screen

import SwiftUI
import SwiftData

// defining a screen (UI component)
// ContentView = the name of your screen
// : View = this tells Swift: “This is something that can be displayed on the screen”
struct ContentView: View {
    
    // MARK: - Properties
    
    // @Query automatically fetches all saved HealthEntry objects from SwiftData
    // "give me the entries stored in the app's database"
    
//    // screen now shows a dynamic list of saved entries
//    @Query var entries: [HealthEntry]
//    SwiftData always fetches in chronological order, newest first
    @Query(sort: \HealthEntry.date, order: .reverse) var entries: [HealthEntry]
    
    // gives this view access to the SwiftData model context
    // modelContext lets us insert, delete, and manage saved data
    @Environment(\.modelContext) var context
    
    // @State stores temporary UI state for this screen
    // showSheet tracks whether the AddEntryView sheet is open or closed
    @State private var showSheet = false
    
    // UI layout of your screen
    // Every SwiftUI view must have a body, it returns what gets drawn on the screen
    // “What should this screen look like?”
    var body: some View {
        
        // creates a navigation system = a container that manages screens
        // allows: titles at the top ("Entries"), navigation between screens
        NavigationStack {
            
            // List creates a scrollable list of items
            // here, it will display saved health insights and saved health entries
            List {
                
                // compact insights section gives quick health-style summary stats
                // this version takes up less vertical space than the previous stacked layout
                Section("Summary") {
                    HStack {
                        
                        // first insight: average sleep across all entries
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Avg Sleep")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(averageSleep, specifier: "%.1f") hrs")
                                .font(.headline)
                        }
                        
                        Spacer()
                        
                        // second insight: average heart rate across all entries
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Avg HR")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(averageHeartRate, specifier: "%.0f") bpm")
                                .font(.headline)
                        }
                        
                        Spacer()
                        
                        // third insight: total number of logged entries
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Entries")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(entryCount)")
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // separate section title for the actual saved entries
                // this makes the screen feel more organized and easier to scan
                Section("Logged Entries") {
                    
                    // ForEach loops through every HealthEntry in entries
                    // and creates UI for each one
                    
                    // “Take every saved HealthEntry and display it as a row on the screen”
                    ForEach(entries) { entry in
                        
                        // NavigationLink makes each row tappable
                        // so the user can tap a row and open a full detail screen
                        NavigationLink {
                            
                            // sends the selected HealthEntry into EntryDetailView
                            // so that screen can display the full information for that one entry
                            EntryDetailView(entry: entry)
                            
                        } label: {
                            
                            // label defines what the tappable row looks like on the main screen
                            // this is the visible content the user sees before tapping
                            VStack(alignment: .leading, spacing: 8) {
                                
                                // main row text: sleep is the most important metric shown first
                                // making it headline gives the row a stronger visual hierarchy
                                Text("Sleep: \(entry.sleepHours, specifier: "%.1f") hrs")
                                    .font(.headline)
                                
                                // secondary details are grouped below the main metric
                                // the list screen is meant to be a quick summary,
                                // so it only shows heart rate and date
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    // shows heart rate in beats per minute
                                    Text("Heart Rate: \(entry.heartRate) bpm")
                                    
                                    // shows the entry date in a formatted style
                                    Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                }
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            }
                            
                            // adds vertical spacing inside each row
                            // this makes the list feel less cramped and easier to read
                            .padding(.vertical, 6)
                        }
                    }
                    // enables swipe-to-delete on list rows
                    // when user deletes, deleteEntry function gets called
                    .onDelete(perform: deleteEntry)
                }
            }
            
            // sets the top title of the screen
            .navigationTitle("Entries")
            
            // adds buttons or controls to the navigation bar
            .toolbar {
                
                // creates a button with a "+" label
                Button("+") {
                    // when tapped, open the AddEntryView sheet
                    showSheet = true
                }
            }
            
            // .sheet presents another screen modally from the bottom
            // when showSheet becomes true, AddEntryView appears
            .sheet(isPresented: $showSheet) {
                AddEntryView()
            }
        }
    }
    
    // MARK: - Helper / Computed Properties
    
    // computed property for the total number of saved entries
    // this updates automatically whenever entries changes
    var entryCount: Int {
        entries.count
    }
    
    // computed property for average sleep across all entries
    // if there are no entries yet, return 0 so the app does not crash
    var averageSleep: Double {
        guard !entries.isEmpty else { return 0.0 }
        
        let totalSleep = entries.reduce(0) { partialResult, entry in
            partialResult + entry.sleepHours
        }
        
        return totalSleep / Double(entries.count)
    }
    
    // computed property for average heart rate across all entries
    // if there are no entries yet, return 0
    var averageHeartRate: Double {
        guard !entries.isEmpty else { return 0.0 }
        
        let totalHeartRate = entries.reduce(0) { partialResult, entry in
            partialResult + Double(entry.heartRate)
        }
        
        return totalHeartRate / Double(entries.count)
    }
    
    // MARK: - Actions
    
    // function to delete entries from the list, UI tells you the position (offset) and you delete that from the database
    // When you swipe to delete in a SwiftUI List, Swift automatically tells you:
    // "the user wants to delete item(s) at these positions in the list"
    // Those positions are passed into the function as: offsets: IndexSet
    // offsets tells us which row(s) the user wants to delete
    func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            context.delete(entries[index])
        }
    }
}

// just for Xcode preview mode
// lets you see the UI without running the simulator
// not part of the actual app logic
#Preview {
    ContentView()
}

//orginal starter template
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
