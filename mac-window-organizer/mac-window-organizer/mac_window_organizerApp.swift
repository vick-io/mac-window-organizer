//
//  mac_window_organizerApp.swift
//  mac-window-organizer
//
//  Created by Vick Gill on 2025-01-25.
//

import SwiftUI

@main
struct mac_window_organizerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
