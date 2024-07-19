//
//  AssignmentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/3/24.
//

import SwiftUI
import ExytePopupView

private struct FloatingView: View {
    @ObservedObject var assignmentViewModel: AssignmentViewModel
    @Binding var isPresentedFloating: Bool
    @Binding var modifySignment: Signment
    @State private var content: String = ""
    @State private var date: Date = Date()
    var viewTitle: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                SubNameView(title: viewTitle, geoSize: geo.size)
                VStack {
                    SubCalendarView(date: $date, geoSize: geo.size)
                    SubContentView(content: $content, geoSize: geo.size)
                }
                
                Spacer()
                
                HStack {
                    SubButtonsView(assignmentViewModel: assignmentViewModel,
                                   isPresentedFloating: $isPresentedFloating,
                                   modifySignment: $modifySignment,
                                   viewTitle: viewTitle,
                                   geoSize: geo.size,
                                   date: date,
                                   content: content)
                }
                .frame(width: geo.size.width ,alignment: .bottomTrailing)
            }
            .onAppear() {
                assignmentViewModel.readData()
            }
            .frame(width: geo.size.width * 0.91, height: geo.size.height * 0.92, alignment: .center)
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

func dateToString(date: Date) -> String {
    print("\(date)")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = Date()
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

// MARK: - FloatingView SubView
struct SubNameView: View {
    var title: String
    var geoSize: CGSize
    
    var body: some View {
        Text(title)
            .font(.system(size: 30))
            .frame(alignment: .leading)
            .bold()
        
        Divider()
            .frame(height: 1)
            .frame(width: geoSize.width)
            .background(.mint)
    }
}

struct SubCalendarView: View {
    @Binding var date: Date
    var geoSize: CGSize
    
    var body: some View {
        HStack{
            Spacer()
                .frame(width: geoSize.width * 0.03)
            
            Image(systemName: "calendar")
                .resizable()
                .frame(width: geoSize.width * 0.09, height: geoSize.height * 0.05)
            Text("Date")
        }
        .frame(width: geoSize.width, alignment: .leading)
        
        DatePicker("", selection: $date)
            .datePickerStyle(GraphicalDatePickerStyle())
        
        Spacer()
            .frame(height: geoSize.height * 0.05)
        
        Divider()
            .frame(height: 1)
            .background(.mint)
            .frame(width: geoSize.width)
    }
}

struct SubContentView: View {
    @Binding var content: String
    var geoSize: CGSize
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: geoSize.width * 0.03)
            
            Image(systemName: "doc")
                .resizable()
                .frame(width: geoSize.width * 0.09, height: geoSize.height * 0.05)
            
            Text("Content")
        }
        .frame(width: geoSize.width, alignment: .leading)
        
        TextField("일정 내용을 입력해 주세요.", text: $content)
        
        Spacer()
            .frame(height: geoSize.height * 0.04)
        
        Divider()
            .frame(height: 1)
            .frame(width: geoSize.width)
            .background(.mint)
    }
}

struct SubButtonsView: View {
    @ObservedObject var assignmentViewModel: AssignmentViewModel
    @Binding var isPresentedFloating: Bool
    @Binding var modifySignment: Signment
    var viewTitle: String
    var geoSize: CGSize
    var date: Date
    var content: String
    
    var body: some View {
        Button {
            isPresentedFloating = false
            
        } label: {
            Image(systemName: "pencil.slash")
                .resizable()
                .frame(width: geoSize.width * 0.09, height: geoSize.height * 0.05)
                .foregroundColor(.red)
        }
        
        Button {
            if viewTitle == "Add Content" {
                assignmentViewModel.createData(date: dateToString(date: date), content: content)
            } else if viewTitle == "Modify"{
                assignmentViewModel.readData()
                assignmentViewModel.updateData(checkedTodoList: modifySignment.checkedTodoList, date: dateToString(date: date), content: content, preContent: modifySignment.content)
            }
            
            assignmentViewModel.readData()
            
            isPresentedFloating = false
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: geoSize.width * 0.09, height: geoSize.height * 0.05)
                .foregroundColor(.mint)
        }
        
        Spacer()
            .frame(width: geoSize.width * 0.05)
    }
}
// MARK: - AssinmentView Main

struct AssignmentView: View {
    @ObservedObject var assignmentViewModel: AssignmentViewModel = AssignmentViewModel()
    @State var isPresentFloatingForCreate: Bool = false
    @State var isPresentedFloatingForModify: Bool = false
    @State var modifySignment: Signment = Signment(checkedTodoList: false, date: "", content: "")
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    Button {
                        isPresentFloatingForCreate = true
                    } label: {
                        Text("+   ")
                            .font(.system(size: 50))
                            .frame(width:geo.size.width ,height: geo.size.height * 0.05, alignment: .trailing)
                            .foregroundColor(.mint)
                            .bold()
                    }
                    
                    Divider()
                    
                    VStack{
                        List {
                            ForEach($assignmentViewModel.signments) { $assignment in
                                VStack {
                                    HStack{
                                        Toggle(isOn: $assignment.checkedTodoList) {
                                        }
                                        .onChange(of: assignment.checkedTodoList) { changedValue in
                                            assignmentViewModel.updateData(checkedTodoList: changedValue, date: assignment.date, content: assignment.content, preContent: assignment.content)
                                        }
                                        .frame(width: geo.size.width * 0.15, height: 100, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        Divider()
                                            .frame(height: geo.size.height * 0.05)
                                            .frame(width: 1.5)
                                            .background(.mint)
                                        
                                        
                                        Spacer()
                                        
                                        if assignment.checkedTodoList {
                                            Text("\(assignment.date)\n\(assignment.content)")
                                                .frame(width: geo.size.width * 0.5, alignment: .leading)
                                                .background(Color.clear)
                                                .strikethrough(color: .red)
                                                .shadow(radius: 5)
                                        } else {
                                            Text("\(assignment.date)\n\(assignment.content)")
                                                .frame(width: geo.size.width * 0.5, alignment: .leading)
                                                .background(Color.clear)
                                                .shadow(radius: 5)
                                        }
                                        
                                        Spacer()
                                        
                                        Button {
                                            modifySignment = Signment(checkedTodoList: assignment.checkedTodoList, date: assignment.date, content: assignment.content)
                                            isPresentedFloatingForModify = true
                                        } label: {
                                            Image(systemName: "pencil.line")
                                                .resizable()
                                                .frame(width: geo.size.width * 0.09, height: geo.size.height * 0.05)
                                                .foregroundColor(.mint)
                                                .shadow(radius: 5)
                                        }
                                        .disabled(assignment.checkedTodoList)
                                        
                                        Spacer()
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
            }
            .sheet(isPresented: $isPresentFloatingForCreate, onDismiss: {
            }) {
                FloatingView(assignmentViewModel: assignmentViewModel, isPresentedFloating: $isPresentFloatingForCreate,
                             modifySignment: $modifySignment, viewTitle: "Add Content")
            }
            .sheet(isPresented: $isPresentedFloatingForModify, onDismiss: {
            }) {
                FloatingView(assignmentViewModel: assignmentViewModel, isPresentedFloating: $isPresentedFloatingForModify,
                             modifySignment: $modifySignment, viewTitle: "Modify")
            }
        }
        .navigationTitle("ASSIGNMENT")
    }
}

#Preview {
    AssignmentView()
}
