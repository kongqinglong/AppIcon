//
//  Sidebar.swift
//  AppIcon
//
//  Created by kongqinglong on 2022/2/28.
//

import SwiftUI

/// **SideBar**
/// 左边栏菜单
struct Sidebar: View {
    var body: some View {
        VStack(alignment: .leading) {
            title
            List {
                Text("test hello")
            }
        }
        .frame(alignment:.topLeading)
    }
    
    var title: some View {
        Label {
            Text("AppIcon")
        } icon: {
            Image(systemName: "app.gift")
                .foregroundColor(.mint)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
