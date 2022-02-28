//
//  AppIconDocument.swift
//  Shared
//
//  Created by kongqinglong on 2022/2/17.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var appIcons: UTType {
        UTType(importedAs: "com.kfxfy.uitools.appicons")
    }
}

class AppIconDocument: ReferenceFileDocument {
    
    @Published  var text: String = ""

    static var readableContentTypes: [UTType] { [.appIcons] }
    static var writableContentTypes: [UTType] { [.appIcons] }    

    init() {        
    }
    
    required init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
//    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//        let data = text.data(using: .utf8)!
//        return .init(regularFileWithContents: data)
//    }

    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }

    func snapshot(contentType: UTType) throws -> Data {
        return text.data(using: .utf8)!
    }
}
