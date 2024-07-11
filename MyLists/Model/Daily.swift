//
//  Daily.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import Foundation

class Daily: ToDo {
    override init(checkedTodoList: Bool, date: Date, content: String) {
        super.init(checkedTodoList: checkedTodoList, date: date, content: content)
    }
}
