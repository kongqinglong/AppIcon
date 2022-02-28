//
//  View+UIImage.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/2/28.
//

import SwiftUI
//#if os(macOS)
//typealias UIImage = NSImage
//typealias UIHostingController = NSHostingController
//#else
//#endif

#if os(iOS)
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    // save photo
    // UIImageWriteToSavedPhotosAlbum(image)
    // Info.plist添加NSPhotoLibraryAddUsageDescription
}
#endif

#if os(macOS)
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

    func saveAsImage(url: URL, imageType: NSBitmapImageRep.FileType = .png) -> Bool {
        let nsView = NoInsetHostingView(rootView: self)
        nsView.setFrameSize(nsView.fittingSize)

        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!        
        bitmapRep.size = nsView.bounds.size
        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
        
        let data = bitmapRep.representation(using: imageType, properties: [:])
        do {
            try data?.write(to: url)
            return true
        } catch {
            print("write to \(url.lastPathComponent) error: \(error.localizedDescription)")
            return false
        }
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
#endif
