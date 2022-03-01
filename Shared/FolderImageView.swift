//
//  FolderImageView.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/3/1.
//

import SwiftUI

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


struct FolderImageView_Previews: PreviewProvider {
    static var previews: some View {
        FolderImageView()
    }
}
