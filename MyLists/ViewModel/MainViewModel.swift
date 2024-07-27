//
//  AssignmentViewModel.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/11/24.
//

import Foundation
import Firebase
import SwiftUI

final class MainViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var documentId: String = ""
    
    @Published var toDoArray = [ToDo]()
    @Published var selectedToDo: ToDo? = nil
    @Published var groupArray = [Group]()
    
    func readData(collection: String) {
        db.collection(collection).getDocuments { querySnapshot, error in
            if let error = error {
                print("querySnapshot을 불러올 수 없습니다. : \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    switch collection {
                    case CollectionName.toDoList.rawValue:
                        self.toDoArray = querySnapshot.documents.compactMap { document in
                            do {
                                return try document.data(as: ToDo.self)
                            } catch {
                                return nil
                            }
                        }
                    case CollectionName.groupList.rawValue:
                        self.groupArray = querySnapshot.documents.compactMap { document in
                            do {
                                return try document.data(as: Group.self)
                            } catch {
                                return nil
                            }
                        }
                    default:
                        return
                    }
                }
            }
        }
    }
    
    func createData(collection: String, dataForCreate: Dictionary<String, Any>) {
        db.collection(collection).addDocument(data: dataForCreate)
        
        switch collection {
        case CollectionName.toDoList.rawValue:
            addToDoList(todoData: dataForCreate)
        case CollectionName.groupList.rawValue:
            addGroupList(groupData: dataForCreate)
        default:
            return
        }
        
        print("정상적으로 데이터가 추가되었습니다.")
    }
    
    func updateData(collection: String, dataForUpdate: Dictionary<String, Any>, comparisonTarget: String) {
        let field: String = setField(collection: collection)
        
        db.collection(collection)
            .whereField(field, isEqualTo: comparisonTarget)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("querySnapshot을 불러올 수 없습니다. : \(error.localizedDescription)")
                } else {
                    if let querySnapshot = querySnapshot {
                        for document in querySnapshot.documents {
                            document.reference.updateData(dataForUpdate) { error in
                                if let error = error {
                                    print("Document Update에 실패하였습니다.: \(error.localizedDescription)")
                                } else {
                                    switch collection {
                                    case "ToDoList" :
                                        self.updateToDoList(todoData: dataForUpdate, content: comparisonTarget)
                                        print("Document \(document.documentID)가 정상적으로 Update 되었습니다.")
                                    case "GroupList" :
                                        self.updateGroupList(groupData: dataForUpdate, name: comparisonTarget)
                                        print("Document \(document.documentID)가 정상적으로 Update 되었습니다.")
                                    default:
                                        return
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        // db.collection("myLists").document("L5ezBrVuHDKVmIK7VBlE").updateData(["name": "Jaehyun", "lastName": "Shin", "gender": "man", "age": "31"])
    }
    
    
    
    func deleteData(collection: String, comparisonTarget: String) {
        let field: String = setField(collection: collection)
        
        db.collection(collection)
            .whereField(field, isEqualTo: comparisonTarget)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("querySnapshot을 불러올 수 없습니다. : \(error)")
                } else {
                    if let querySnapshot = querySnapshot {
                        for document in querySnapshot.documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("제거 도중 에러가 발생했습니다 : \(error)")
                                } else {
                                    switch collection {
                                    case CollectionName.toDoList.rawValue:
                                        self.toDoArray = self.toDoArray.filter { $0.content != comparisonTarget }
                                        print("정상적으로 \(document.documentID)가 삭제 되었습니다.")
                                    case CollectionName.groupList.rawValue:
                                        self.groupArray = self.groupArray.filter { $0.name != comparisonTarget }
                                        print("정상적으로 \(document.documentID)가 삭제 되었습니다.")
                                    default:
                                        return
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        //db.collection("myLists").document("L5ezBrVuHDKVmIK7VBlE").updateData(["age": FieldValue.delete()])
    }
    
    func addToDoList(todoData: Dictionary<String, Any>) {
        let toDo = ToDo(checkedTodoList: todoData["checkedTodoList"] as! Bool, group: todoData["group"] as! String, date: todoData["date"] as! String, time: todoData["time"] as! String, content: todoData["content"] as! String)
        
        toDoArray.append(toDo)
    }
    
    func updateToDoList(todoData: Dictionary<String, Any>, content: String) {
        for index in 0...toDoArray.count - 1 {
            if toDoArray[index].content == content {
                let toDo = ToDo(checkedTodoList: todoData["checkedTodoList"] as! Bool, group: todoData["group"] as! String, date: todoData["date"] as! String, time: todoData["time"] as! String, content: todoData["content"] as! String)
                toDoArray[index] = toDo
            }
        }
    }
    
    func addGroupList(groupData: Dictionary<String, Any>) {
        let group = Group(name: groupData["name"] as! String, color: groupData["color"] as! String)
        
        groupArray.append(group)
    }
    
    func updateGroupList(groupData: Dictionary<String, Any>, name: String) {
        for index in 0...groupArray.count - 1 {
            if groupArray[index].name == name {
                let group = Group(name: groupData["name"] as! String, color: groupData["color"] as! String)
                groupArray[index] = group
            }
        }
    }
    
    func setField(collection: String) -> String {
        switch collection {
        case CollectionName.toDoList.rawValue:
            return "content"
        case CollectionName.groupList.rawValue:
            return "name"
        default:
            return ""
        }
    }
}
