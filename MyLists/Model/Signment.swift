//
//  Signment.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/8/24.
//

import Foundation

class Signment: ToDo {
    override init(checkedTodoList: Bool, date: String, content: String) {
        super.init(checkedTodoList: checkedTodoList, date: date, content: content)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        self.id = UUID()
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
