//
//  AppIconView.swift
//  Shared
//
//  Created by kongqinglong on 2022/2/17.
//

import SwiftUI

struct AppIconView: View {
    //@EnvironmentObject var document: AppIconDocument
    @AppStorage("\(Self.self)_fileName")
    var fileName: String = ""
    
    var body: some View {
        NavigationView {
            Sidebar()

            VStack {
                imageView
                HStack {
                    TextField("AppIcon文件名", text: $fileName)
                        .frame(width: 220)

                    Button(action: {saveIcon()}) {
                        Label { Text("保存为AppIcon") }
                        icon: {
                            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                .foregroundColor(.mint)
                        }
                    }
                    
                    Button(action: {saveImage()}) {
                        Label("保存为图像", systemImage: "photo")
                    }
                }
                Spacer()
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationTitle("AppIcon")
        }
    }
    
    
    var imageView: some View {
        IconSetView()
    }
    
}

#if os(macOS)
// MARK: - 保存到文件
extension AppIconView {
    // 用户本地目录
    static let documentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func saveImage() {
        let url = Self.documentDirectory.appendingPathComponent("3.png")
        _ = imageView.saveAsImage(url: url, imageType: .png, newSize: CGSize(width: 256, height: 256))
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: Self.documentDirectory.path)
    }
    
    /// Icon最大的尺寸是[1024, 1024]
    ///
    func saveIcon() {
        guard !fileName.isEmpty else {return}
        let appIconDir = Self.documentDirectory.appendingPathComponent("\(fileName).appiconset")
        if !FileManager.default.fileExists(atPath: appIconDir.path) {
            do {
                try FileManager.default.createDirectory(at: appIconDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("create \(appIconDir.lastPathComponent) error")
                return
            }
        }

        var images: [AppIconItem] = []

        AppIconSet.prefix = fileName
        for iconSet in AppIconItem.allIcons {
            let url = appIconDir.appendingPathComponent(iconSet.fullname)
            if  imageView.saveAsImage(url: url, newSize: iconSet.pixelSize ) {
                images.append(iconSet)
            }
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        let iconSet = AppIconSet(images: images)
        if let data = try? encoder.encode(iconSet), let contents = String(data: data, encoding: .utf8) {
            print("contents: \n \(contents)")
            let contentsURL = appIconDir.appendingPathComponent(AppIconSet.contents)
            try? data.write(to: contentsURL)
        }
        
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: appIconDir.path)

    }
    
    
}
#endif //#if os(macOS)

#if os(iOS)
// MARK: - iOS版的保存函数
extension AppIconView {
    func saveImage() {
        
    }
}
#endif //#if os(iOS)

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AppIconDocument(configuration: AppIconDocument.ReadConfiguration()))
//    }
//}




extension CGRect {
    var end: CGPoint {
        CGPoint(x: minX + width, y: minY + height)
    }
}

