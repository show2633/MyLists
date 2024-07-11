//
//  AssignmentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/3/24.
//

import SwiftUI
import ExytePopupView

private struct FloatingView: View {
    @Binding var isPresentedFloating: Bool
    @State private var content: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Text("Add Content")
                    .font(.system(size: 30))
                    .frame(alignment: .leading)
                    .bold()
                Divider()
                    .frame(height: 1)
                    .frame(width: geo.size.width)
                    .background(.mint)
                
                VStack {
                    Spacer()
                        .frame(height: geo.size.height * 0.04)
                    HStack{
                        Spacer()
                            .frame(width: geo.size.width * 0.03)
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: geo.size.width * 0.09, height: geo.size.height * 0.05)
                        Text(" Date")
                    }
                    .frame(width: geo.size.width, alignment: .leading)
                    
                    DatePicker("", selection: $date)
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.05)
                    
                    Divider()
                        .frame(height: 1)
                        .background(.mint)
                        .frame(width: geo.size.width)
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.05)
                    
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width * 0.03)
                        
                        Image(systemName: "doc")
                            .resizable()
                            .frame(width: geo.size.width * 0.09, height: geo.size.height * 0.05)
                        Text("Content")
                    }
                    .frame(width: geo.size.width, alignment: .leading)
                    
                    TextField("일정 내용을 입력해 주세요.", text: $content)
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.04)
                    
                    Divider()
                        .frame(height: 1)
                        .frame(width: geo.size.width)
                        .background(.mint)
                }
                
                Spacer()
                
                HStack {
                    Button {
                        print(date)
                        isPresentedFloating = false
                        
                    } label: {
                        Image(systemName: "pencil.slash")
                            .resizable()
                            .frame(width: geo.size.width * 0.09, height: geo.size.height * 0.05)
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        // AssignmentViewModel의 Create관련 함수 불러와서 저장
                        // AssignmentViewModel의 Read관련 함수 불러와서 불러오기
                        isPresentedFloating = false
                    } label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: geo.size.width * 0.09, height: geo.size.height * 0.05)
                            .foregroundColor(.mint)
                    }
                    
                    Spacer()
                        .frame(width: geo.size.width * 0.05)
                }
                .frame(width: geo.size.width ,alignment: .bottomTrailing)
            }
            .frame(width: geo.size.width * 0.91, height: geo.size.height * 0.75, alignment: .center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.mint)
            )
        }
        Spacer()
    }
}

struct AssignmentView: View {
    @State private var isPresentFloating = false
    @State private var checkedTodoList = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    Button {
                        isPresentFloating = true
                    } label: {
                        Text("+   ")
                            .font(.system(size: 50))
                            .frame(width:geo.size.width ,height: geo.size.height * 0.05, alignment: .trailing)
                            .foregroundColor(.mint)
                            .bold()
                    }
                    
                    VStack{
                        List {
                            HStack {
                                Toggle(isOn: $checkedTodoList) {
                                    // AssignmentViewModel의 update 함수 불러오기
                                }
                                .frame(width: geo.size.width * 0.15, height: 100, alignment: .leading)
                                
                                Spacer()
                                
                                if checkedTodoList {
                                    Text("2024-07-15 20:02:12 \n할 일 내용")
                                        .frame(width: geo.size.width * 0.68, alignment: .leading)
                                        .background(Color.clear)
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                // AssignmentViewModel Delete 함수 불러오기
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                        .strikethrough(color: .red)
                                } else {
                                    Text("2024-07-15 20:02:12 \n할 일 내용")
                                        .background(Color.clear)
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                // AssignmentViewModel Delete 함수 불러오기
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                        .frame(width: geo.size.width * 0.68, alignment: .leading)
                                }
                            }
                        }.listStyle(.plain)
                            
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.90, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.mint)
                    )
                }
                .onAppear() {
                    
                    // AssignmentViewModel의 Read관련 함수 불러와서 불러오기
                }
                .sheet(isPresented: $isPresentFloating, onDismiss: {
                    
                }) {
                    FloatingView(isPresentedFloating: $isPresentFloating)
                }
            }
            .navigationTitle("ASSIGNMENT")
        }
        
    }
    
//    @ObservedObject var tv = TestViewModel()
//    var coreDataManager = CoreDataManager()
//    
//    var body: some View {
//        VStack{
//            List(tv.testModels) { tm in
//                HStack {
//                    Text("\(tm.content)")
//                    Text("\(tm.time)")
//                }
//                .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                    Button {
//                         } label: {
//                             Label("Delete", systemImage: "trash.circle")
//                         }
//                             .tint(.red)
//                }
//            }
//           
//        }
//        .navigationTitle("test")
//        .onAppear() {
//            tv.readData()
//            
//            var testModel: TestModel = TestModel()
//            testModel.content = "TestContent"
//            testModel.time = "TestTime"
//            coreDataManager.insertTestModel(testModel)
//        }
//        
//        VStack {
//            Button(action: {
//                let testModels = coreDataManager.getModelCore()
//                for testModel in testModels {
//                    print("Content: \(testModel.content), Time: \(testModel.time)")
//                }
//            }) {
//                Text("Save and Fetch User")
//            }
//        }
//    }
}

#Preview {
    AssignmentView()
}
