# Pickup Basketball Scheduler App

## Description

This iOS application helps users find local basketball courts and schedule pickup games. It allows users to view court details, see their location on a map, and add their own scheduled game times, including the number of people attending. The app features a simple one-time profile setup and stores all scheduled game data locally on the device.

## Features

* **Court Listing:** Displays a list of nearby basketball courts loaded from a local JSON file.
* **Court Details:** Shows address, notes, and an interactive map (using MapKit) displaying the location of a selected court.
* **Game Scheduling:** Allows users to add scheduled games for specific courts, including:
    * Date and Time
    * Optional Time Description (e.g., "Around 5 PM")
    * Number of people attending
    * Optional Notes
    * Scheduler's Name (taken from user profile)
* **Local Storage:**
    * Scheduled games are saved locally to the device's file system using `Codable` and `FileManager`.
    * User profile name and setup status are saved using `UserDefaults` (`@AppStorage`).
* **Profile Setup:** A simple "What is your name?" prompt appears on the first launch to personalize the app experience.
* **SwiftUI Interface:** Built entirely with Apple's modern declarative UI framework, SwiftUI.



