//
//  AppIconApp.swift
//  Shared
//
//  Created by kongqinglong on 2022/2/17.
//

import SwiftUI

@main
struct AppIconApp: App {
    var body: some Scene {
        WindowGroup {
            AppIconView()
        }
    }
    
    var docScene: some Scene {
        DocumentGroup(newDocument: { AppIconDocument() }) { config in
            AppIconView()
                .environmentObject(config.document)
        }
    }
}
