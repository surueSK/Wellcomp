//
//  TodoStore.swift
//  a2019term
//
//  Created by 助川友理 on 2019/12/25.
//  Copyright © 2019 助川友理. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TodoStore:ObservableObject {
    var todos:[todos]{
        didSet{didChange.send()}
    }
    init(todos:[todos]=[]) {
        self.todos=todos
    }
    var didChange = PassthroughSubject<Void,Never>()
}
