//
//  AppIconView.swift
//  Shared
//
//  Created by kongqinglong on 2022/2/17.
//

import SwiftUI

struct AppIconView: View {
    //@EnvironmentObject var document: AppIconDocument
    @State var fileName: String = ""
    
    var body: some View {
        //TextEditor(text: document.text)
        NavigationView {
            Sidebar()

            VStack {
                imageView
                HStack {
                    TextField("AppIcon文件名", text: $fileName)
                        .frame(width: 220)

                    Button(action: {}) {
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
            }
        }
    }
    
    
    var imageView: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: 25, dy: 25)
            let path = Path(roundedRect: rect, cornerRadius: 30)
                        
            let gradient = Gradient(colors: [.blue, .cyan])
            let from = rect.origin
            let to =   CGPoint(x: from.x + rect.width, y: from.y + rect.height)
            
            // border
            context.stroke(path, with: .color(.blue), lineWidth: 1)
            
            // background
            context.fill(path, with: .linearGradient(gradient, startPoint: from, endPoint: to))

            // cloud
            let cloudRect = CGRect(x: rect.width*0.15, y: rect.height*0.12, width: rect.width*0.8, height: rect.height*0.8)
//            let cloudImage = context.resolve(Image(systemName: "cloud"))
            let cloudImage = context.resolve(Image(systemName: "book"))
            context.draw(cloudImage, in: cloudRect, style: FillStyle())

            // music
//            let musicImage = context.resolve(Image(systemName: "music.quarternote.3"))
            let musicImage = context.resolve(Image(systemName: "music.note.list"))
//            let musicImage = context.resolve(Image(systemName: "music.note"))
            let imageRect = CGRect(x: rect.width*0.23, y: rect.height*0.37, width: rect.width*0.25, height: rect.height*0.3)
            //let gradientMusic = Gradient(colors: [.blue, .mint])
            //musicImage.shading = .linearGradient(gradientMusic, startPoint: from, endPoint: to)

            context.draw(musicImage, in: imageRect, style: FillStyle())
        }
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.mint]), startPoint: .top, endPoint: .bottom)
//                .frame(width: width, height: height, alignment: .center)
//                .opacity(0.7)
//                .cornerRadius(16)
            
//            Image(systemName: "music.note.list")
//                .resizable()
//                .frame(width: width * 0.8, height: height * 0.8, alignment: .center)
//                .opacity(0.8)
//                .foregroundStyle(.secondary)
                
//            Image(systemName: "music.quarternote.3")
//                .resizable()
//                .frame(width: width * 0.4, height: height * 0.4, alignment: .topLeading)
//                .opacity(0.8)
//                .foregroundColor(.white)

//        }
    }

    var width: CGFloat { 1024/2 }
    var height: CGFloat { 1024/2 }
}


// MARK: - 保存到文件
extension AppIconView {
    // 用户本地目录
    static let documentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func saveImage() {
        let url = Self.documentDirectory.appendingPathComponent("2.png")
        _ = imageView.saveAsImage(url: url)
        #if os(macOS)
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: Self.documentDirectory.path)
        #endif
    }
    
    /// Icon最大的尺寸是[1024, 1024]
    ///
    func saveIcon() {
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AppIconDocument(configuration: AppIconDocument.ReadConfiguration()))
//    }
//}


struct FolderImageView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.mint]), startPoint: .top, endPoint: .bottom)
                .opacity(0.7)
                .frame(width: width, height: height, alignment: .center)
                .cornerRadius(16)
            Image(systemName: "folder")
                .resizable()
                .opacity(0.8)
                .foregroundColor(.white)
                .frame(width: width/2, height: height/2, alignment: .center)
        }
    }
    
    var width: CGFloat { 1024/2 }
    var height: CGFloat { 1024/2 }
}
