//
//  ToDoPreviewView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import SwiftUI

struct ToDoPreviewView: View {
    var listRawValue: String
    var body: some View {
        VStack {
            switch listRawValue {
            case ListsType.signature.rawValue:
                Text("signature")
            case ListsType.workOut.rawValue:
                Text("workout")
            case ListsType.daily.rawValue:
                Text("daily")
            case ListsType.meet.rawValue:
                Text("meet")
            default:
                Text("")
            }
        }
    }
}

#Preview {
    ToDoPreviewView(listRawValue: "")
}
