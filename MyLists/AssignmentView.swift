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
    @ObservedObject var assignmentViewModel: AssignmentViewModel
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
                        assignmentViewModel.createData(date: dateToString(date: date), content: content)
                        assignmentViewModel.readData()
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
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}

struct AssignmentView: View {
    @ObservedObject var assignmentViewModel: AssignmentViewModel = AssignmentViewModel()
    @State private var isPresentFloating = false
    
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
                            ForEach($assignmentViewModel.signments) { $assignment in
                                VStack {
                                    Spacer()
                                    
                                    HStack{
                                        Toggle(isOn: $assignment.checkedTodoList) {
                                            
                                        }
                                        .onChange(of: assignment.checkedTodoList) { changedValue in
                                            assignmentViewModel.updateData(checkedTodoList: changedValue, date: assignment.date, content: assignment.content)
                                        }
                                        .frame(width: geo.size.width * 0.15, height: 100, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        if assignment.checkedTodoList {
                                            Text("\(assignment.date)\n\(assignment.content)")
                                                .frame(width: geo.size.width * 0.68, alignment: .leading)
                                                .background(Color.clear)
                                                .strikethrough(color: .red)
                                        } else {
                                            Text("\(assignment.date)\n\(assignment.content)")
                                                .frame(width: geo.size.width * 0.68, alignment: .leading)
                                                .background(Color.clear)
                                        }
                                    }
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            assignmentViewModel.deleteData(content: assignment.content)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
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
                assignmentViewModel.readData()
                // AssignmentViewModel의 Read관련 함수 불러와서 불러오기
            }
            .sheet(isPresented: $isPresentFloating, onDismiss: {
            }) {
                FloatingView(isPresentedFloating: $isPresentFloating, assignmentViewModel: assignmentViewModel)
            }
        }
        .navigationTitle("ASSIGNMENT")
    }
}

#Preview {
    AssignmentView()
}
