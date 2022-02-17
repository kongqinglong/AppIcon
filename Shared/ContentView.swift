//
//  ContentView.swift
//  Shared
//
//  Created by kongqinglong on 2022/2/17.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: AppIconDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(AppIconDocument()))
    }
}
