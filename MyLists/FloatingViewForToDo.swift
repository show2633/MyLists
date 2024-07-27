//
//  FloatingViewForToDo.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct FloatingViewForToDo: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State var selectedGroup: String = ""
    @State var selectedDate = Date()
    @State var selectedTime = Date()
    @State var content: String = ""
    var comparisonTarget: String?
    var checkedFunction: String
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: SetSectionHeader(title: "Group")) {
                        setGroup()
                    }
                    
                    Section(header: SetSectionHeader(title: "Date")) {
                        setDate()
                    }
                    
                    Section(header:SetSectionHeader(title: "Content")) {
                        setContent()
                    }
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    setToolbarButton(imageName: SetToolBarButtonImageName.squareArrowUp.rawValue)
                }
                ToolbarItem(placement:.topBarLeading) {
                    setToolbarButton(imageName: SetToolBarButtonImageName.xmarkSquare.rawValue)
                }
            }
            .onAppear() {
                if let selectedGroup = mainViewModel.groupArray.first?.name {
                    self.selectedGroup = selectedGroup
                }
            }
        }
    }
    
    
}

//MARK: - ViewBuilder
extension FloatingViewForToDo {
    @ViewBuilder
    func setGroup() -> some View {
        Picker("", selection: $selectedGroup) {
            ForEach(mainViewModel.groupArray) { group in
                Text(group.name).tag(group.name)
                    .font(Font.custom(FontName.saemaul.rawValue, size: 20))
            }
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .pickerStyle(.wheel)
    }
    
    @ViewBuilder
    func setDate() -> some View {
        HStack {
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .frame(alignment: .leading)
                .labelsHidden()
            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                .datePickerStyle(.automatic)
                .frame(alignment: .leading)
                .labelsHidden()
        }
    }
    
    @ViewBuilder
    func setContent() -> some View {
        TextField("일정을 입력 해 주세요.", text: $content)
            .font(Font.custom(FontName.saemaul.rawValue, size: 17))
            .foregroundColor(.black)
    }
    
    @ViewBuilder
    func setToolbarButton(imageName: String) -> some View {
        Button {
            switch imageName {
            case SetToolBarButtonImageName.squareArrowUp.rawValue:
                switch checkedFunction {
                case Function.create.rawValue:
                    mainViewModel.createData(collection: CollectionName.toDoList.rawValue, dataForCreate: buildToDoData(checkedTodoList: nil, group: selectedGroup, date: dateToString(date: selectedDate), time: timeToString(date: selectedTime), content: content, isCompleted: false))
                    
                    dismiss()
                case Function.update.rawValue:
                    mainViewModel.updateData(collection: CollectionName.toDoList.rawValue, dataForUpdate: buildToDoData(checkedTodoList: nil, group: selectedGroup, date: dateToString(date: selectedDate), time: timeToString(date: selectedTime), content: content, isCompleted: false), comparisonTarget: comparisonTarget ?? "")
                
                    dismiss()
                default:
                    return
                }
            case SetToolBarButtonImageName.xmarkSquare.rawValue:
                dismiss()
            default:
                return
            }
            
        } label: {
            Image(systemName: imageName)
                .foregroundColor(.mint)
        }
    }
}

//#Preview {
//    FloatingViewForToDo(sheetModalForToDo: true)
//}
