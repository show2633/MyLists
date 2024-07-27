//
//  ContentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 6/25/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel: MainViewModel = MainViewModel()
    @State var sheetModalForToDoCreate: Bool = false
    @State var sheetModalForToDoUpdate: Bool = false
    @State var sheetModalForGroupControl: Bool = false
    @State var sheetModalForGroupCreate: Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedTodo: ToDo?
    @State var isExpanded = false
    
    var body: some View {
        ZStack { 
            VStack {
                LazyVStack {
                    LinearCalendar(selectedDate: $selectedDate)
                }
                
                Divider()
                
                LazyVStack {
                    List {
                        setCompletedToDoList()
                        setDecompletedToDoList()
                    }
                    .frame(height: 580)
                    .listStyle(.plain)
                }
                .sheet(item: $selectedTodo, content: { todo in
                    FloatingViewForToDo(mainViewModel: mainViewModel,comparisonTarget: todo.content,  checkedFunction: Function.update.rawValue)
                        .presentationDetents([.medium])
                })
                
                Spacer()
            }
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    setFloatingActionButtons()
                }
            }
        }
        .onAppear() {
            mainViewModel.readData(collection: CollectionName.groupList.rawValue)
            mainViewModel.readData(collection: CollectionName.toDoList.rawValue)
        }
    }
}

//MARK: - ViewBuilder
extension MainView {
    @ViewBuilder
    func setToDo(bindingToDo: Binding<ToDo>, toDo: ToDo, group: Group...) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex: group.first?.color ?? "") ?? Color.cyan, lineWidth: 3).opacity(0.7)
        VStack {
            HStack {
                Toggle("", isOn: bindingToDo.checkedTodoList)
                    .onChange(of: bindingToDo.wrappedValue.checkedTodoList) { oldValue, newValue in
                        for (index, tempToDo) in mainViewModel.toDoArray.enumerated() {
                            if tempToDo.content == toDo.content {
                                mainViewModel.toDoArray[index].changeIsCompleted(checkedValue: newValue)
                            }
                        }
                        
                        mainViewModel.selectedToDo = toDo
                        mainViewModel.updateData(collection: CollectionName.toDoList.rawValue, dataForUpdate: buildToDoData(checkedTodoList: toDo.checkedTodoList, group: toDo.group, date: toDo.date, time: toDo.time, content: toDo.content ?? "", isCompleted: newValue), comparisonTarget: mainViewModel.selectedToDo?.content ?? "")
                    }
                    .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .foregroundColor(.red)
                    .bold()
                    .padding(3)
                
                Spacer()
                
                Button {
                        mainViewModel.selectedToDo = toDo
                        selectedTodo = mainViewModel.selectedToDo
                } label: {
                    Image(systemName: ToDoImageName.applePencil.rawValue)
                        .resizable()
                        .bold()
                }
                .frame(width: 25, height: 25)
                .foregroundColor(.red)
                
                Button {
                    mainViewModel.deleteData(collection: CollectionName.toDoList.rawValue, comparisonTarget: toDo.content ?? "")
                } label: {
                    Image(systemName: ToDoImageName.minusCircle.rawValue)
                        .resizable()
                        .bold()
                }
                .frame(width: 25, height: 25)
                .foregroundColor(.red)
                .padding(.trailing, 4)
            }
            setText(text: toDo.date, fontSize: 18)
            setText(text: toDo.time, fontSize: 13)
            
            ScrollView {
                setText(text: toDo.content ?? "", fontSize: 15)
                    .padding()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func setTodoArray(completedOrNot: String, group: Group?) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach($mainViewModel.toDoArray) { $toDo in
                    if let group = group { // 완료 안된거
                        if dateToString(date: selectedDate) == toDo.date &&
                            completedOrNot == CompletedOrNot.deCompleted.rawValue && !($toDo.wrappedValue.isCompleted ?? false) &&
                            group.name == toDo.group {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:150 , height: 150)
                                .overlay {
                                    setToDo(bindingToDo: $toDo, toDo: toDo, group: group)
                                }
                                .foregroundColor(.clear)
                                .background(.clear)
                        }
                    } else { // 완료된거
                        if dateToString(date: selectedDate) == toDo.date &&
                            completedOrNot == CompletedOrNot.completed.rawValue && $toDo.wrappedValue.isCompleted ?? false {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:150 , height: 150)
                                .overlay {
                                    setToDo(bindingToDo: $toDo, toDo: toDo)
                                }
                                .foregroundColor(.clear)
                                .background(.clear)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func setSectionHeaderWithCircle(title: String, circleColor: Color) -> some View {
        HStack {
            Circle()
                .fill(circleColor)
                .frame(width: 15, height: 15)
            Text(title)
        }
    }
    
    @ViewBuilder
    func setCompletedToDoList() -> some View {
        Section(header: setSectionHeaderWithCircle(title: "완료", circleColor: Color.cyan)
            .font(Font.custom(FontName.saemaul.rawValue, size: 19))
            .foregroundColor(.cyan)) {
                setTodoArray(completedOrNot: CompletedOrNot.completed.rawValue, group: nil)
            }
    }
    
    @ViewBuilder
    func setDecompletedToDoList() -> some View {
        ForEach(mainViewModel.groupArray) { group in
            Section(header: setSectionHeaderWithCircle(title: group.name, circleColor: Color(hex: group.color) ?? Color.black)
                .font(Font.custom(FontName.saemaul.rawValue, size: 20))
                .foregroundColor(Color(hex: group.color) ?? Color.black)) {
                    setTodoArray(completedOrNot :CompletedOrNot.deCompleted.rawValue, group: group)
                }
        }
    }
    
    @ViewBuilder
    func setFloatingActionButtons() -> some View {
        VStack {
            if isExpanded {
                FloatingActionButton(imageName: FloationActionButtonImageName.rectangle3Group.rawValue) {
                    sheetModalForGroupCreate = true
                }
                .sheet(isPresented: $sheetModalForGroupCreate, content: {
                    FloatingViewForGroupCreate(mainViewModel: mainViewModel, sheetModalForGroupCreate: $sheetModalForGroupCreate)
                        .presentationDetents([.medium])
                })
                FloatingActionButton(imageName: FloationActionButtonImageName.plus.rawValue) {
                    sheetModalForToDoCreate = true
                }
                .sheet(isPresented: $sheetModalForToDoCreate, content: {
                    FloatingViewForToDo(mainViewModel: mainViewModel, checkedFunction: Function.create.rawValue)
                        .presentationDetents([.medium])
                })
                
                FloatingActionButton(imageName: FloationActionButtonImageName.rectanglePencilEllipsis.rawValue) {
                    sheetModalForGroupControl = true
                }
                .sheet(isPresented: $sheetModalForGroupControl, content: {
                    FloatingViewForGroupControl(mainViewModel: mainViewModel, sheetModalForGroupControl: $sheetModalForGroupControl)
                        .presentationDetents([.medium])
                })
            }
            
            FloatingActionButton(imageName: isExpanded ? FloationActionButtonImageName.minusCircleFill.rawValue : FloationActionButtonImageName.plusCircleFill.rawValue) {
                withAnimation() {
                    isExpanded.toggle()
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func setText(text:String, fontSize: CGFloat) -> some View {
        Text(text)
            .font(Font.custom(FontName.saemaul.rawValue, size: fontSize))
            .foregroundColor(.black)
    }
}

// MARK: - ETC

extension MainView {
    // 토글 체크박스 Style
    struct CheckboxToggleStyle: ToggleStyle {
        @Environment(\.isEnabled) var isEnabled
        let style: Style
        
        func makeBody(configuration: Configuration) -> some View {
            Button {
                configuration.isOn.toggle()
            } label: {
                HStack {
                    Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : style.sfSymbolName)
                        .imageScale(.large)
                    configuration.label
                }
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!isEnabled)
        }
        
        enum Style {
            case square, circle
            
            var sfSymbolName: String {
                switch self {
                case .square:
                    return "square"
                case .circle:
                    return "circle"
                }
            }
        }
    }
}

#Preview {
    MainView()
}
