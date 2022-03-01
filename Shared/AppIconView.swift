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
                Spacer()
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationTitle("AppIcon")
        }
    }
    
    
    /// Canvas学习资料
    /// https://developer.apple.com/documentation/swiftui/graphicscontext
    /// https://www.raywenderlich.com/1101-core-graphics-on-macos-tutorial
    /// Getting Context
    /// ```swift
    /// let context = NSGraphicsContext.current()?.cgContext  // type is CGContext?
    /// extension NSView {
    ///     var currentContext : CGContext {
    ///             let context = NSGraphicsContext.current()
    ///                     return context!.cgContext
    ///             }
    /// }
    /// extension CGContext{
    ///     func protectGState(_ drawStuff: () -> Void) {
    ///             saveGState()
    ///             drawStuff()
    ///             restoreGState()
    ///     }
    /// }
    /// let context = UIGraphicsGetCurrentContext()  // type is CGContext?
    /// UIGraphicsBeginImageContext
    /// ```
    /// https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/HandlingImages/Images.html
    /// 获取pixel数据
    /// https://blog.slaunchaman.com/tag/cgcontext/
    /// https://swiftui-lab.com/swiftui-animations-part5/
    ///
    var imageView: some View {
        HStack{
            Canvas(rendersAsynchronously: true) { context, size in
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
                let cloudRect = CGRect(x: rect.width*0.16, y: rect.height*0.12, width: rect.width*0.8, height: rect.height*0.8)
                var cloudImage = context.resolve(Image(systemName: "book"))
                cloudImage.shading = GraphicsContext.Shading.color(.white)
                //cloudImage.shading = .linearGradient(Gradient(colors: [.white, .purple]), startPoint: cloudRect.origin, endPoint: cloudRect.end)
                context.draw(cloudImage, in: cloudRect, style: FillStyle())
                
                // music
                var musicImage = context.resolve(Image(systemName: "music.note.list"))
                musicImage.shading = GraphicsContext.Shading.color(.white)
                let imageRect = CGRect(x: rect.width*0.24, y: rect.height*0.37, width: rect.width*0.25, height: rect.height*0.3)
                
                context.draw(musicImage, in: imageRect, style: FillStyle())
            }
            .frame(width: width, height: height, alignment: .topLeading)
        }
    }

    var ratio: CGFloat { 0.5 }
    var width: CGFloat { 1024 * ratio }
    var height: CGFloat { 1024 * ratio }
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
        let appIconDir = Self.documentDirectory.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: appIconDir.path) {
            do {
                try FileManager.default.createDirectory(at: appIconDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("create \(appIconDir.lastPathComponent) error")
                return
            }
        }
        
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


extension CGRect {
    var end: CGPoint {
        CGPoint(x: minX + width, y: minY + height)
    }
}
