//
//  todos.swift
//  a2019term
//
//  Created by 助川友理 on 2019/12/22.
//  Copyright © 2019 助川友理. All rights reserved.
//

import SwiftUI

struct todos: Identifiable{
    var id = UUID()
    var name: String
    var time: Int
}

#if DEBUG
let testData = [
    todos(name:"風呂",time:1),
    todos(name:"洗面所",time:2),
    todos(name:"食事",time:3),
    todos(name:"歯磨き",time:4),
    todos(name:"化粧",time:5)
]
#endif
