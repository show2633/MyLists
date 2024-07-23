//
//  File.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/19/24.
//

import Foundation

func dateToString(date: Date) -> String {
    print("\(date)")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = Date()
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}
