//
//  AssignmentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/3/24.
//

import SwiftUI

struct AssignmentView: View {
    @ObservedObject var tv = TestViewModel()
    var coreDataManager = CoreDataManager()
    
    var body: some View {
        VStack{
            List(tv.testModels) { tm in
                HStack {
                    Text("\(tm.content)")
                    Text("\(tm.time)")
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                         } label: {
                             Label("Delete", systemImage: "trash.circle")
                         }
                             .tint(.red)
                }
            }
           
        }
        .onAppear() {
            tv.readData()
            
            var testModel: TestModel = TestModel()
            testModel.content = "TestContent"
            testModel.time = "TestTime"
            coreDataManager.insertTestModel(testModel)
        }
        
        VStack {
            Button(action: {
                let testModels = coreDataManager.getModelCore()
                for testModel in testModels {
                    print("Content: \(testModel.content), Time: \(testModel.time)")
                }
            }) {
                Text("Save and Fetch User")
            }
        }
    }
}

#Preview {
    AssignmentView()
}
