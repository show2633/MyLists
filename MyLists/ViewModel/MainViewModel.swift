//
//  AssignmentViewModel.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/11/24.
//

import Foundation
import Firebase

final class MainViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var documentId: String = ""
    
    @Published var toDoArray = [ToDo]()
    
    func readData() {
        db.collection("myLists").getDocuments { querySnapshot, error in
            if let error = error {
                print("querySnapshot을 불러올 수 없습니다. : \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    self.toDoArray = querySnapshot.documents.compactMap { document in
                        do {
                            return try document.data(as: ToDo.self)
                        } catch {
                            return nil
                        }
                    }
                }
            }
        }
    }
    
    func createData(group: String, date:String, time: String, content: String) {
        db.collection("myLists").addDocument(data: ["checkedTodoList": false, "group": group, "date": date, "time": time, "content": content])
        print("정상적으로 데이터가 추가되었습니다.")
    }
    
    func updateData(checkedTodoList: Bool, group: String, date: String, time: String, content: String, preContent: String) {
        db.collection("myLists")
            .whereField("content", isEqualTo: preContent)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("querySnapshot을 불러올 수 없습니다. : \(error.localizedDescription)")
                } else {
                    if let querySnapshot = querySnapshot {
                        for document in querySnapshot.documents {
                            document.reference.updateData(["checkedTodoList": false, "group": group, "date": date, "time": time, "content": content]) { error in
                                if let error = error {
                                    print("Document Update에 실패하였습니다.: \(error.localizedDescription)")
                                } else {
                                    self.readData()
                                    print("Document \(document.documentID)가 정상적으로 Update 되었습니다.")
                                }
                            }
                        }
                    }
                }
            }
        // db.collection("myLists").document("L5ezBrVuHDKVmIK7VBlE").updateData(["name": "Jaehyun", "lastName": "Shin", "gender": "man", "age": "31"])
    }
    
    
    
    func deleteData(content: String) {
        
        db.collection("myLists")
            .whereField("content", isEqualTo: content)
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
                                    self.toDoArray = self.toDoArray.filter { $0.content != content }
                                    print("정상적으로 \(document.documentID)가 삭제 되었습니다.")
                                }
                            }
                        }
                    }
                }
            }
        //db.collection("myLists").document("L5ezBrVuHDKVmIK7VBlE").updateData(["age": FieldValue.delete()])
    }
}
