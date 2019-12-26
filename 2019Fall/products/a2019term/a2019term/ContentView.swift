//
//  ContentView.swift
//  a2019term
//
//  Created by 助川友理 on 2019/12/19.
//  Copyright © 2019 助川友理. All rights reserved.
//

import SwiftUI
// メニュー画面？開始

struct ContentView: View {
 @ObservedObject var store = TodoStore()
 var todos: [todos] = []
    var body: some View {
        ZStack{
            Color.blue
              .edgesIgnoringSafeArea(.all)
        VStack {
            Text("ADLogger")
            .font(.title)
            .foregroundColor(.orange)
            Text("HOME")
            .foregroundColor(.orange)
            NavigationView {
            NavigationLink(destination: SubContentView()) {
                    Text("TODO & StopWatch")
                        .font(.title)
                        .foregroundColor(.orange)
                
                }
              }
            }
        }
    }
}

// TODO画面
struct SubContentView: View {
    @ObservedObject var store = TodoStore()
    var todos: [todos] = []
    @State var isShown = false
    var body: some View {
        NavigationView{
            List {
                Button(action: addTask) {
                    Text("Add Task").alert(isPresented:$isShown) {
                        Alert(title: Text("Alert"))
                    }
                }
                ForEach(store.todos){
                todos in
            HStack{
                NavigationLink(destination:Text(todos.name)){
                        Text(todos.name)
                        Text("\(todos.time)")
                }
                
                Button(action: {
                    self.gettime()
                    print("hello")
                }) {
                    Text("START")
                }
                
            }
            }.onDelete(perform:delete)
                    .onMove(perform:move)
             .navigationBarItems(trailing: EditButton())
             .navigationBarTitle(Text("TODOS & STOPWATCH"))
            }
        }

    }
    func addTask(){
        self.isShown = true
        //store.todos.append(<#todos#>)
    }
    func delete(at offsets:IndexSet){
        store.todos.remove(atOffsets:offsets)
    }
    func move(from source:IndexSet,to destination:Int){
        store.todos.move(fromOffsets: source, toOffset: destination)
    }
//時間取得機能↓
    let formatter = DateFormatter()
    weak var timer:Timer!
    var startTime = Date()
    func gettime(){
        formatter.timeStyle = .full
        formatter.dateStyle = .full
        let now = Date()
        print(formatter.string(from: now))
    }
//時間取得機能↑
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(store:TodoStore(todos:testData))
        SubContentView(store:TodoStore(todos:testData))
    }
}
#endif

