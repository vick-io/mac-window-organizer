//
//  ad.swift
//  mac-window-organizer
//
//  Created by Vick Gill on 2025-01-25.
//


import AppKit

extension NSRunningApplication {
    var mainWindow: AXUIElement? {
        let app = AXUIElementCreateApplication(self.processIdentifier)
        var value: AnyObject?
        AXUIElementCopyAttributeValue(app, kAXFocusedWindowAttribute as CFString, &value)
        return value as! AXUIElement // force unwrap - look into other options
    }
}

extension AXUIElement {
    func setFrame(_ frame: CGRect) {
        var origin = frame.origin
        var size = frame.size
        
        let position = AXValueCreate(.cgPoint, &origin)!
        let sizeValue = AXValueCreate(.cgSize, &size)!
        
        AXUIElementSetAttributeValue(self, kAXPositionAttribute as CFString, position)
        AXUIElementSetAttributeValue(self, kAXSizeAttribute as CFString, sizeValue)
    }
}
