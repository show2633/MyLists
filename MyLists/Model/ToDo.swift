//
//  ToDo.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import Foundation

class ToDo {
    var id: UUID
    var checkedTodoList: Bool
    var date: Date
    var content: String
    
    init(checkedTodoList: Bool, date: Date, content: String) {
        self.id = UUID()
        self.checkedTodoList = checkedTodoList
        self.date = date
        self.content = content
    }
}
