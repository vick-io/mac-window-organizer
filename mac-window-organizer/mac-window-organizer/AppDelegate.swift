//
//  AppDelegate.swift
//  mac-window-organizer
//
//  Created by Vick Gill on 2025-01-25.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var eventMonitor: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        checkAccessibilityPermissions()
        setupHotkeys()
    }

    func checkAccessibilityPermissions() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
        let isTrusted = AXIsProcessTrustedWithOptions(options)
        print("Accessibility Permissions Granted:", isTrusted)
    }

    func setupHotkeys() {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.modifierFlags.contains([.command, .option]) {
                switch event.keyCode {
                case 123: // Left arrow
                    self?.moveWindowToLeft()
                case 124: // Right arrow
                    self?.moveWindowToRight()
                case 125: // Up Arrow
                    self?.moveWindowToTop()
                case 126: // Down Arrow
                    self?.moveWindowToBottom()
                default:
                    break
                }
            }
            
            if event.modifierFlags.contains([.command, .option, .control]) {
                switch event.keyCode {
                case 123: // Left arrow
                    self?.moveWindowToLeftThird()
                default:
                    break
                }
            }
        }
    }

    func moveWindowToLeft() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else { return }
        guard let window = frontmostApp.mainWindow else { return }
        
        let screenFrame = NSScreen.main?.frame ?? .zero
        let newFrame = CGRect(
            x: screenFrame.origin.x,
            y: screenFrame.origin.y,
            width: screenFrame.width / 2,
            height: screenFrame.height
        )
        
        window.setFrame(newFrame)
        print("Moved window to left")
    }
    
    func moveWindowToLeftThird() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else { return }
        guard let window = frontmostApp.mainWindow else { return }
        
        let screenFrame = NSScreen.main?.frame ?? .zero
        let newFrame = CGRect(
            x: screenFrame.origin.x,
            y: screenFrame.origin.y,
            width: screenFrame.width / 3,
            height: screenFrame.height
        )
        
        window.setFrame(newFrame)
        print("Moved window to left")
    }

    func moveWindowToRight() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else { return }
        guard let window = frontmostApp.mainWindow else { return }
        
        let screenFrame = NSScreen.main?.frame ?? .zero
        let newFrame = CGRect(
            x: screenFrame.width / 2,
            y: screenFrame.origin.y,
            width: screenFrame.width / 2,
            height: screenFrame.height
        )
        
        window.setFrame(newFrame)
        print("Moved window to right")
    }
    
    func moveWindowToTop() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication,
              let window = frontmostApp.mainWindow else { return }
        
        let screenFrame = NSScreen.main?.frame ?? .zero
        let newFrame = CGRect(
            x: screenFrame.origin.x,
            y: screenFrame.height / 2,
            width: screenFrame.width,
            height: screenFrame.height / 2
        )
        
        window.setFrame(newFrame)
        print("Moved window to top half")
    }

    func moveWindowToBottom() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication,
              let window = frontmostApp.mainWindow else { return }
        
        let screenFrame = NSScreen.main?.frame ?? .zero
        let newFrame = CGRect(
            x: screenFrame.origin.x,
            y: screenFrame.origin.y,
            width: screenFrame.width,
            height: screenFrame.height / 2
        )
        
        window.setFrame(newFrame)
        print("Moved window to bottom half")
    }
}
