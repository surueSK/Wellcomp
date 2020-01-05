//
//  ToDoItemView.swift
//  2019fterm
//
//  Created by 助川友理 on 2020/01/04.
//  Copyright © 2020 助川友理. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    var title:String = ""
    var createdAt:String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                .font(.headline)
                Text(createdAt)
                .font(.caption)
            }
            Text("1")
            Button(action: {
                gettime()
            }){
                Text("START")
            }
        }
    }
}

//時間取得機能
let formatter = DateFormatter()
weak var timer:Timer!
var startTime = Date()
func gettime(){
    formatter.timeStyle = .full
    formatter.dateStyle = .full
    let now = Date()
    print(formatter.string(from: now))
}

#if DEBUG
struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView()
    }
}
#endif
