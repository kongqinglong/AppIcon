//
//  AppIconSet.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/2/28.
//

import SwiftUI

struct AppIconItem {
    let idiom: String
    let filename: String
    let size: CGSize
    let scale: Int
    
    init(idiom: String,  size: CGFloat, scale: Int) {
        self.idiom = idiom
        //self.filename = String(format: "app_icon_%gx%g@%dx.png", size, size, scale)
        let pixelSize = size * CGFloat(scale)
        self.filename = String(format: "app_icon_%gx%g.png", pixelSize, pixelSize)
        self.size = CGSize(width: size, height: size)
        self.scale = scale
    }
    
    var pixelSize: CGSize {
        CGSize(width: size.width*CGFloat(scale), height: size.height*CGFloat(scale))
    }
    
    var fullname: String {
        AppIconSet.prefix.isEmpty ? filename : "\(AppIconSet.prefix)_\(filename)"
    }
}

// MARK: - Encoding
extension AppIconItem: Encodable {
    enum CodingKeys: CodingKey {
        case filename, idiom, scale, size
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fullname, forKey: .filename)
        try container.encode(idiom, forKey: .idiom)
        try container.encode("\(scale)x", forKey: .scale)
        try container.encode(String(format: "%gx%g", size.width, size.height), forKey: .size)
    }
}

// MARK: -AppIcon集合
extension AppIconItem {
    static let allIcons: [AppIconItem] = [
        .init(idiom: "iphone",          size: 20,   scale: 2),
        .init(idiom: "iphone",          size: 20,   scale: 3),
        .init(idiom: "iphone",          size: 29,   scale: 2),
        .init(idiom: "iphone",          size: 29,   scale: 3),
        .init(idiom: "iphone",          size: 40,   scale: 2),
        .init(idiom: "iphone",          size: 40,   scale: 3),
        .init(idiom: "iphone",          size: 60,   scale: 2),
        .init(idiom: "iphone",          size: 60,   scale: 3),
        .init(idiom: "ipad",            size: 20,   scale: 1),
        .init(idiom: "ipad",            size: 20,   scale: 2),
        .init(idiom: "ipad",            size: 29,   scale: 1),
        .init(idiom: "ipad",            size: 29,   scale: 2),
        .init(idiom: "ipad",            size: 40,   scale: 1),
        .init(idiom: "ipad",            size: 40,   scale: 2),
        .init(idiom: "ipad",            size: 76,   scale: 1),
        .init(idiom: "ipad",            size: 76,   scale: 2),
        .init(idiom: "ipad",            size: 83.5, scale: 2),
        .init(idiom: "ios-marketing",   size: 1024, scale: 1),
        .init(idiom: "mac",             size: 16,   scale: 1),
        .init(idiom: "mac",             size: 16,   scale: 2),
        .init(idiom: "mac",             size: 32,   scale: 1),
        .init(idiom: "mac",             size: 32,   scale: 2),
        .init(idiom: "mac",             size: 128,  scale: 1),
        .init(idiom: "mac",             size: 128,  scale: 2),
        .init(idiom: "mac",             size: 256,  scale: 1),
        .init(idiom: "mac",             size: 256,  scale: 2),
        .init(idiom: "mac",             size: 512,  scale: 1),
        .init(idiom: "mac",             size: 512,  scale: 2),
    ]
}


// MARK: - Contents.json对应的Json struct
struct AppIconSet: Encodable {
    struct Info: Encodable {
        let author: String
        let version: Int
    }
    
    let images: [AppIconItem]
    let info: Info
    
    init(images: [AppIconItem]) {
        self.images = images
        info = Info(author: "xcode", version: 1)
    }
    
    static let contents = "Contents.json"
    /// IconSet目录名前缀
    static var prefix: String = ""
}

