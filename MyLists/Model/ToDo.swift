//
//  ToDo.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import Foundation

class ToDo: Identifiable, Codable {
    var id: UUID
    var checkedTodoList: Bool
    var group: String
    var date: String
    var time: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case checkedTodoList
        case group
        case date
        case time
        case content
    }
    
    init(checkedTodoList: Bool, group: String, date: String, time: String, content: String) {
        self.id = UUID()
        self.checkedTodoList = checkedTodoList
        self.group =  group
        self.date = date
        self.time = time
        self.content = content
    }
    
    required init(from decoder: Decoder) throws {
        self.id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.checkedTodoList = try container.decode(Bool.self, forKey: .checkedTodoList)
        self.group = try container.decode(String.self, forKey: .group)
        self.date = try container.decode(String.self, forKey: .date)
        self.time = try container.decode(String.self, forKey: .time)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checkedTodoList, forKey: .checkedTodoList)
        try container.encode(group, forKey: .group)
        try container.encode(date, forKey: .date)
        try container.encode(time, forKey: .time)
        try container.encode(content, forKey: .content)
    }
}
