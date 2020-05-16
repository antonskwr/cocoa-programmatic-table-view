//
//  AppDelegate.swift
//  SingleViewTest
//
//  Created by Anton Skvartsou on 19/06/2018.
//  Copyright © 2018 Anton Skvartsou. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let windowCotroller = WindowCotroller(window:
        NSWindow(contentRect: NSRect(x: 200,
                                     y: 300,
                                     width: 400,
                                     height: 300),
                 styleMask: [.closable, .miniaturizable, .titled],
                 backing: .buffered,
                 defer: true))


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        windowCotroller.showWindow(self)
        
        print("We are here!!")
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}


class WindowCotroller: NSWindowController, NSWindowDelegate {
    
    override init(window: NSWindow?) {
        super.init(window: window)
        
        window?.delegate = self
        window?.setFrameUsingName(NSWindow.FrameAutosaveName(rawValue: "MyWindowww"))
        window?.titlebarAppearsTransparent = true
        window?.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        window?.aspectRatio = NSSize(width: 4, height: 3)
        window?.collectionBehavior = .fullScreenNone
        window?.minSize = NSSize(width: 400, height: 300)
        
        
        let viewController = MainViewController()
        viewController.view.frame = window!.frame
        window?.contentViewController = viewController
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func windowWillClose(_ notification: Notification) {
        window?.saveFrame(usingName: NSWindow.FrameAutosaveName(rawValue: "MyWindowww"))
    }
    
}











