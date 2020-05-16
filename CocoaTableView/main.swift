//
//  main.swift
//  SingleViewTest
//
//  Created by Anton Skvartsou on 19/06/2018.
//  Copyright © 2018 Anton Skvartsou. All rights reserved.
//

import AppKit

let app = NSApplication.shared
NSApp.setActivationPolicy(.regular)
NSApp.activate(ignoringOtherApps: true)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
