//
//  ContentView.swift
//  ADLoggerv1
//
//  Created by 助川友理 on 2020/05/18.
//  Copyright © 2020 助川友理. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
        HStack{
            Text("0")
            Text("0")
            Text(":")
            Text("0")
            Text("0")
            Text(":")
            Text("0")
            Text("0")
        }
            Button(action: {
                
            }) {
                Text("START")
            }
            Button(action: {
                
            }) {
                Text("LOG")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
