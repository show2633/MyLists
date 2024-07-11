//
//  WorkOut.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import Foundation

class WorkOut: ToDo {
    override init(checkedTodoList: Bool, date: String, content: String) {
        super.init(checkedTodoList: checkedTodoList, date: date, content: content)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
