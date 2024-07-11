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
    var date: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case checkedTodoList, date, content
    }
    
    init(checkedTodoList: Bool, date: String, content: String) {
        self.id = UUID()
        self.checkedTodoList = checkedTodoList
        self.date = date
        self.content = content
    }
    
    required init(from decoder: Decoder) throws {
        self.id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.checkedTodoList = try container.decode(Bool.self, forKey: .checkedTodoList)
        self.date = try container.decode(String.self, forKey: .date)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checkedTodoList, forKey: .checkedTodoList)
        try container.encode(date, forKey: .date)
        try container.encode(content, forKey: .content)
    }
}
