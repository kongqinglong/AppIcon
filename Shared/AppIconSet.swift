//
//  AppIconSet.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/2/28.
//

import SwiftUI

struct AppIconSet {
    let idiom: String
    let fileName: String
    let size: CGSize
    let scale: Int
    
    init(idiom: String,  edge: CGFloat, scale: Int) {
        let dim = edge * CGFloat(scale)
        self.idiom = idiom
        self.fileName = String(format: "%gx%g@%dx.png", edge, edge, scale)
        self.size = CGSize(width: dim, height: dim)
        self.scale = scale
    }
    
    static let allIcons: [AppIconSet] = [
        .init(idiom: "iphone",          edge: 20,   scale: 2),
        .init(idiom: "iphone",          edge: 20,   scale: 3),
        .init(idiom: "iphone",          edge: 29,   scale: 2),
        .init(idiom: "iphone",          edge: 29,   scale: 3),
        .init(idiom: "iphone",          edge: 40,   scale: 2),
        .init(idiom: "iphone",          edge: 40,   scale: 3),
        .init(idiom: "iphone",          edge: 60,   scale: 2),
        .init(idiom: "iphone",          edge: 60,   scale: 3),
        .init(idiom: "ipad",            edge: 20,   scale: 1),
        .init(idiom: "ipad",            edge: 20,   scale: 2),
        .init(idiom: "ipad",            edge: 29,   scale: 1),
        .init(idiom: "ipad",            edge: 29,   scale: 2),
        .init(idiom: "ipad",            edge: 40,   scale: 1),
        .init(idiom: "ipad",            edge: 40,   scale: 2),
        .init(idiom: "ipad",            edge: 76,   scale: 1),
        .init(idiom: "ipad",            edge: 76,   scale: 2),
        .init(idiom: "ipad",            edge: 83.5, scale: 2),
        .init(idiom: "ipad",            edge: 60,   scale: 2),
        .init(idiom: "mac",             edge: 16,   scale: 1),
        .init(idiom: "mac",             edge: 16,   scale: 2),
        .init(idiom: "mac",             edge: 32,   scale: 1),
        .init(idiom: "mac",             edge: 32,   scale: 2),
        .init(idiom: "mac",             edge: 128,  scale: 1),
        .init(idiom: "mac",             edge: 128,  scale: 2),
        .init(idiom: "mac",             edge: 256,  scale: 1),
        .init(idiom: "mac",             edge: 256,  scale: 2),
        .init(idiom: "mac",             edge: 512,  scale: 1),
        .init(idiom: "mac",             edge: 512,  scale: 2),
        .init(idiom: "ios-marketing",   edge: 1024, scale: 1),
    ]
}

