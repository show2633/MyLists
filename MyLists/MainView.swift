//
//  ContentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 6/25/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel: MainViewModel = MainViewModel()
    @State private var isChecked = false
    @State var sheetModalForToDo = false
    @State var sheetModalForGroup = false
    
    var body: some View {
        ZStack {
            VStack {
                LazyVStack {
                    LinearCalendar()
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
    }
    
//MARK: - ViewBuilder
    
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
    func setToDo() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.cyan, lineWidth: 3).opacity(0.7)
        VStack {
            HStack {
                Toggle("", isOn: $isChecked)
                    .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .foregroundColor(.red)
                    .bold()
                    .padding(3)
                
                Spacer()
            }
            Text("오늘의 할 일")
                .font(Font.custom("HS새마을체", size: 18))
                .foregroundColor(.black)
            Text("17:00:00")
                .font(Font.custom("HS새마을체", size: 13))
                .foregroundColor(.black)
            ScrollView {
                Text("네 이것저것이 있네요")
                    .font(Font.custom("HS새마을체", size: 15))
                    .foregroundColor(.black)
                    .padding()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func setTodoArray() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(TodoGroup.allCases) { g in
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width:150 , height: 150)
                        .overlay {
                            setToDo()
                        }
                        .foregroundColor(.clear)
                        .background(.clear)
                }
                
            }
        }
    }
    
    @ViewBuilder
    func setCompletedToDoList() -> some View {
        Section(header: setSectionHeaderWithCircle(title: "완료", circleColor: Color.cyan)
            .font(Font.custom("HS새마을체", size: 19))
            .foregroundColor(.cyan)) {
                setTodoArray()
            }
    }
    
    @ViewBuilder
    func setDecompletedToDoList() -> some View {
        ForEach(TodoGroup.allCases) { group in
            Section(header: setSectionHeaderWithCircle(title: group.rawValue, circleColor: Color.black)
                .font(Font.custom("HS새마을체", size: 20))
                .foregroundColor(.black)) {
                    setTodoArray()
                }
        }
    }
    
    @ViewBuilder
    func setFloatingActionButtons() -> some View {
        VStack {
            FloatingActionButton(imageName: "rectangle.3.group") {
                sheetModalForGroup = true
            }
            .sheet(isPresented: $sheetModalForGroup, content: {
                FloatingViewForGroup(sheetModalForGroup: $sheetModalForGroup)
                    .presentationDetents([.medium])
            })
            FloatingActionButton(imageName: "plus") {
                sheetModalForToDo = true
            }
            .sheet(isPresented: $sheetModalForToDo, content: {
                FloatingViewForToDo(sheetModalForToDo: $sheetModalForToDo)
                    .presentationDetents([.medium])
            })
        }
        .padding()
    }
}

// MARK: - ETC

enum TodoGroup: String, Identifiable, CaseIterable {
    case 숙제
    case 미팅
    case 운동
    
    var id: String { self.rawValue }
}

// 토글 체크박스 Style
struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    let style: Style
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : style.sfSymbolName)
                    .imageScale(.large)
                configuration.label
            }
        })
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


#Preview {
    MainView()
}
