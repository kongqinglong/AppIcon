//
//  NSView+NSImage.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/3/1.
//

import SwiftUI


extension View {
    func snapshot() -> NSImage {
        let nsView = NSHostingView(rootView: self)
        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!
        
        bitmapRep.size = nsView.bounds.size
        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
        
        let image = NSImage(size: bitmapRep.size)
        image.addRepresentation(bitmapRep)
        return image
    }

    func saveAsImage(url: URL, imageType: NSBitmapImageRep.FileType = .png, newSize: CGSize? = nil) -> Bool {
        let nsView = NoInsetHostingView(rootView: self)
        nsView.setFrameSize(nsView.fittingSize)
        
        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!
        bitmapRep.size = nsView.bounds.size
        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
        
        guard let cgImage = bitmapRep.cgImage else {return false}
        let nsImage = NSImage(cgImage: cgImage, size: bitmapRep.size)
        if newSize == nil {
            return nsImage.save(url: url)
        } else {
            guard let image = nsImage.resize(newSize: newSize!) else {return false}
            return image.save(url: url)
        }
    }
}

extension NSImage {
    
    /// 缩放图像的几种方法：https://nshipster.com/image-resizing/
    /// https://www.hackingwithswift.com/read/27/3/drawing-into-a-core-graphics-context-with-uigraphicsimagerenderer
    /// https://augmentedcode.io/2020/10/25/resizing-uiimages-with-aspect-scale-to-fill-on-ios/
    /// 
    func resize(newSize: CGSize) -> NSImage? {
        guard let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil, pixelsWide: Int(newSize.width), pixelsHigh: Int(newSize.height),
            bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
            colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)
        else {
            return nil
        }

        bitmapRep.size = newSize
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
        draw(in: NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height),
             from: .zero, operation: .copy, fraction: 1.0)
        NSGraphicsContext.restoreGraphicsState()
        
        let scaledImage = NSImage(size: newSize)
        scaledImage.addRepresentation(bitmapRep)
        return scaledImage
    }

    func save(url: URL, imageType: NSBitmapImageRep.FileType = .png) -> Bool {
        guard let rep = self.tiffRepresentation,
              let imageRep = NSBitmapImageRep(data: rep),
              let data = imageRep.representation(using: imageType, properties: [:])
        else { return false }
        
        do {
            try data.write(to: url)
            return true
        } catch {
            print("save \(url.path) error: \(error.localizedDescription)")
        }
        return false
    }
}

extension NSView {
    func snapshot() -> NSImage? {
        guard let bitmapRep = bitmapImageRepForCachingDisplay(in: bounds) else { return nil }
        cacheDisplay(in: bounds, to: bitmapRep)
        
        guard let cgImage = bitmapRep.cgImage else { return nil }
        return NSImage(cgImage: cgImage, size: bounds.size)
    }
}

class NoInsetHostingView<V>: NSHostingView<V> where V: View {
    override var safeAreaInsets: NSEdgeInsets {
        return .init()
    }
}
