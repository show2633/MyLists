//
//  ToDoEnums.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/28/24.
//

import Foundation

enum ToDoImageName: String {
    case applePencil = "applepencil.gen1"
    case minusCircle = "minus.circle"
}

enum GroupImageName: String {
    case minusCircle = "minus.circle"
}

enum FloationActionButtonImageName: String {
    case rectangle3Group = "rectangle.3.group"
    case plus = "plus"
    case rectanglePencilEllipsis = "rectangle.and.pencil.and.ellipsis.rtl"
    case plusCircleFill = "plus.circle.fill"
    case minusCircleFill = "minus.circle.fill"
}

enum CompletedOrNot: String {
    case completed = "Completed"
    case deCompleted = "Decompleted"
}

enum Function: String {
    case update = "Update"
    case create = "Create"
}

enum FontName: String {
    case saemaul = "HS새마을체"
}

enum WeekChangeButtonImageName: String {
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
}

enum SetToolBarButtonImageName: String {
    case squareArrowUp = "square.and.arrow.up"
    case xmarkSquare = "xmark.square"
}

enum CollectionName: String {
    case toDoList = "ToDoList"
    case groupList = "GroupList"
}
