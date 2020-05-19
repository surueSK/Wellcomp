//
//  ContentView.swift
//  ADLoggerv1
//
//  Created by 助川友理 on 2020/05/18.
//  Copyright © 2020 助川友理. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var nowDate:Date = Date()
    let referenceDate:Date
    var timer:Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            _ in self.nowDate = Date()
        }
    }
    
    var body: some View {
        Text(countUpString(from: referenceDate))
            .font(.largeTitle)
            .onAppear(perform: {
                _ = self.timer
            })
    }
    func countUpString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02d:%02d:%02d:%02d",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( referenceDate: Date())
    }
}
