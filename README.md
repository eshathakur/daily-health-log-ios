# Daily Health Log (iOS)

A SwiftUI + SwiftData iOS app designed for simple daily health tracking and pattern recognition.

## Overview

This app is built around a **morning check-in workflow**, where users log:

- Sleep (hours from the previous night)
- Resting heart rate (morning)
- Energy level (1–5)
- Optional notes

The goal is to help users identify patterns between recovery, body signals, and perceived energy.

## Features

- 📅 **One entry per day**
  - Prevents duplicate logs for the same date
  - Supports backfilling with a date picker

- 🧠 **Insights Dashboard**
  - Average sleep
  - Average heart rate
  - Total entries logged

- 📊 **Structured Data Tracking**
  - Sleep (input)
  - Resting heart rate (body signal)
  - Energy level (output)

- 📱 **Clean iOS UX**
  - SwiftUI-based interface
  - NavigationStack for screen flow
  - Detail screen for each entry
  - Form validation for safe input

## Tech Stack

- SwiftUI
- SwiftData (for persistence)
- NavigationStack
- MVVM-style structure

## Product Thinking

This app models a simple health feedback loop:

Sleep (input) → Resting HR (signal) → Energy (output)

By logging daily entries, users can begin to recognize trends such as:
- Lower sleep correlating with lower energy
- Elevated heart rate indicating stress or poor recovery

## Future Improvements

- Apple Health integration
- Trend graphs (weekly/monthly)
- Notifications for morning check-ins
- Correlation insights (e.g. sleep vs energy trends)

## Screenshots

_Add screenshots here (main screen, add entry, detail view)_
