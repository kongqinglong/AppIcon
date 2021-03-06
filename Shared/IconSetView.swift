//
//  IconSetView.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/3/1.
//

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
/// AppIcon： https://medium.com/@PixelmatorNinja/pixelmator-tip-19-how-to-design-a-simple-ios7-8-app-icon-8cf45990103f

import SwiftUI

struct IconSetView: View {
    var body: some View {
        HStack{
            appIcon
        }
    }
    
    var ratio: CGFloat { 0.5 }
    var width: CGFloat { 1024 * ratio }
    var height: CGFloat { 1024 * ratio }

}

// MARK: - CloudAudioBooks的图标
extension IconSetView {
    var audioBooks: some View {
        Canvas(rendersAsynchronously: true) { context, size in
            // Icon pixel: 1024* 1024, 圆角45
            let rect = CGRect(origin: .zero, size: size)
            let path = Path(roundedRect: rect, cornerRadius: 45)
            
            let gradient = Gradient(colors: [.blue, .mint])
            let from = rect.origin
            let to =   CGPoint(x: from.x + rect.width, y: from.y + rect.height)
            
            // border
            context.stroke(path, with: .color(.blue), lineWidth: 1)
            
            // background
            context.fill(path, with: .linearGradient(gradient, startPoint: from, endPoint: to))
            
            // cloud
            let cloudRect = CGRect(x: rect.width*0.16, y: rect.height*0.2, width: rect.width*0.7, height: rect.height*0.6)
            var cloudImage = context.resolve(Image(systemName: "book"))
            cloudImage.shading = GraphicsContext.Shading.color(.white)
            context.draw(cloudImage, in: cloudRect, style: FillStyle())
            
            // music
            var musicImage = context.resolve(Image(systemName: "music.note.list"))
            musicImage.shading = GraphicsContext.Shading.color(.white)
            let imageRect = CGRect(x: rect.width*0.24, y: rect.height*0.34, width: rect.width*0.2, height: rect.height*0.3)
            
            context.draw(musicImage, in: imageRect, style: FillStyle())
        }
        .frame(width: width, height: height, alignment: .topLeading)
    }
}

extension IconSetView {
    var appIcon: some View {
        Canvas(rendersAsynchronously: true) { context, size in
            // Icon pixel: 1024* 1024, 圆角45
            let rect = CGRect(origin: .zero, size: size)
            let path = Path(roundedRect: rect, cornerRadius: 45)
            
            let gradient = Gradient(colors: [.blue, .mint])
            let from = rect.origin
            let to =   CGPoint(x: from.x + rect.width, y: from.y + rect.height)
            
            // border
            context.stroke(path, with: .color(.blue), lineWidth: 1)
            
            // background
            context.fill(path, with: .linearGradient(gradient, startPoint: from, endPoint: to))
            
            // cloud
            let cloudRect = CGRect(x: rect.width*0.16, y: rect.height*0.2, width: rect.width*0.7, height: rect.height*0.6)
            var cloudImage = context.resolve(Image(systemName: "crown"))
            cloudImage.shading = GraphicsContext.Shading.color(.white)
            context.draw(cloudImage, in: cloudRect, style: FillStyle())
            
            // music
            var musicImage = context.resolve(Image(systemName: "wand.and.stars"))
            musicImage.shading = GraphicsContext.Shading.color(.yellow)
            let imageRect = CGRect(x: rect.width*0.42, y: rect.height*0.45, width: rect.width*0.15, height: rect.height*0.15)
            
            context.draw(musicImage, in: imageRect, style: FillStyle())
        }
        .frame(width: width, height: height, alignment: .topLeading)
    }
}
struct IconSetView_Previews: PreviewProvider {
    static var previews: some View {
        IconSetView()
    }
}
