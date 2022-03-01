//
//  UIView+UIImage.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/3/1.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer()
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    // save photo
    // UIImageWriteToSavedPhotosAlbum(image)
    // Info.plist添加NSPhotoLibraryAddUsageDescription
}

