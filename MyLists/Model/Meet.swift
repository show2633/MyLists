//
//  Meet.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import Foundation

class Meet: ToDo {
    var location: String
    
    init(checkedTodoList: Bool, date: String, content: String, location: String) {
        self.location = location
        super.init(checkedTodoList: checkedTodoList, date: date, content: content)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
