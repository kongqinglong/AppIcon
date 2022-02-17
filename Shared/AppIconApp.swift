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
        DocumentGroup(newDocument: AppIconDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
