//
//  Group.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import Foundation

struct Group: Identifiable, Codable {
    var id: UUID 
    var name: String
    var color: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case color
    }
    
    init(name: String, color: String) {
        self.id = UUID()
        self.name = name
        self.color = color
    }
    
    init(from decoder: Decoder) throws {
        self.id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.color = try container.decode(String.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
    }
}
