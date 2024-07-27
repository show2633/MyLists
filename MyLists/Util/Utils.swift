//
//  File.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/19/24.
//

import Foundation

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

func timeToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let timeString = dateFormatter.string(from: date)
    
    return timeString
}

func buildToDoData(checkedTodoList: Bool?, group: String, date: String, time: String, content: String, isCompleted: Bool) -> Dictionary<String, Any> {
    var todoData: Dictionary<String, Any> = Dictionary()
    
    todoData["checkedTodoList"] = checkedTodoList ?? false
    todoData["group"] = group
    todoData["date"] = date
    todoData["time"] = time
    todoData["content"] = content
    
    return todoData
}

func buildGroupData(name: String, color: String) -> Dictionary<String, Any> {
    var groupList: Dictionary<String, Any> = Dictionary()
    
    groupList["name"] = name
    groupList["color"] = color
    
    return groupList
}


