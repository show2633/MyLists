//
//  FloatingViewForToDo.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct FloatingViewForToDo: View {
    @State var selectedGroup = TodoGroup.숙제.rawValue
    @State var selectedDate = Date()
    @State var selectedTime = DatePickerComponents()
    @State var selectecColor = Color.black
    @State var content: String = ""
    @Binding var sheetModalForToDo: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: SetSectionHeaderView(title: "Group")) {
                        setGroup()
                    }
                    
                    Section(header: SetSectionHeaderView(title: "Date")) {
                        setDate()
                    }
                    
                    Section(header:SetSectionHeaderView(title: "Content")) {
                       setContent()
                    }
                    
                    Section(header:SetSectionHeaderView(title: "Color")) {
                        setColor()
                    }
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    setToolbarButton(imageName: "square.and.arrow.up")
                }
                ToolbarItem(placement:.topBarLeading) {
                    setToolbarButton(imageName: "xmark.square")
                }
            }
        }
    }
    
//MARK: - ViewBuilder & Function
    
    @ViewBuilder
    func setGroup() -> some View {
        Picker("", selection: $selectedGroup) {
            ForEach(TodoGroup.allCases) { group in
                Text("\(group)").tag(group)
                    .font(Font.custom("HS새마을체", size: 20))
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
            DatePicker("", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                .datePickerStyle(.automatic)
                .frame(alignment: .leading)
                .labelsHidden()
        }
    }
    
    @ViewBuilder
    func setContent() -> some View {
        TextField("일정을 입력 해 주세요.", text: $content)
            .font(Font.custom("HS새마을체", size: 17))
    }
    
    @ViewBuilder
    func setColor() -> some View {
        ColorPicker("", selection: $selectecColor)
            .frame(width: 0, alignment: .center)
            .padding()
    }
    
    @ViewBuilder
    func setToolbarButton(imageName: String) -> some View {
        Button {
            switch imageName {
            case "square.and.arrow.up":
                sheetModalForToDo = false
            case "xmark.square":
                sheetModalForToDo = false
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
