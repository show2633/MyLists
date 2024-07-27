//
//  FloatingViewForGroupUpdate.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/25/24.
//

import SwiftUI

struct FloatingViewForGroupControl: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State var selectedGroup: String = ""
    @State var selectedColor: Color = Color.black
    @State var groupData: Dictionary<String, Any> = Dictionary()
    @Binding var sheetModalForGroupControl: Bool
    
    var body: some View {
        NavigationStack {
            HStack {
                setDeleteButton()
            }
            VStack {
                List {
                    Section(header: SetSectionHeader(title: "Group")) {
                        getGroupAndColor()
                    }
                    
                    Section(header: SetSectionHeader(title: "Color")) {
                       SetColorPicker(selectedColor: $selectedColor)
                    }
                }
            }
            .onAppear() {
                selectedGroup = mainViewModel.groupArray[0].name
                selectedColor = Color(hex: mainViewModel.groupArray[0].color) ?? Color.black
            }
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    setToolbarButton(imageName: SetToolBarButtonImageName.squareArrowUp.rawValue)
                }
                ToolbarItem(placement:.topBarLeading) {
                    setToolbarButton(imageName: SetToolBarButtonImageName.xmarkSquare.rawValue)
                }
            }
        }
    }
}

//MARK: - ViewBuilder
extension FloatingViewForGroupControl {
    @ViewBuilder
    func getGroupAndColor() -> some View {
        Picker("", selection: $selectedGroup) {
            ForEach(mainViewModel.groupArray) { group in
                Text(group.name).tag(group.name)
                    .font(Font.custom(FontName.saemaul.rawValue, size: 20))
            }
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .pickerStyle(.wheel)
        .onChange(of: selectedGroup) { oldValue, newValue in
            let tempGroupList: [Group] = mainViewModel.groupArray.filter { $0.name == newValue }
            selectedColor = Color(hex: tempGroupList[0].color) ?? Color.black
        }
    }
    
    @ViewBuilder
    func setToolbarButton(imageName: String) -> some View {
        Button {
            switch imageName {
            case SetToolBarButtonImageName.squareArrowUp.rawValue:
                mainViewModel.updateData(collection: CollectionName.groupList.rawValue, dataForUpdate: setGroupData(), comparisonTarget: selectedGroup)
                sheetModalForGroupControl = false
            case SetToolBarButtonImageName.xmarkSquare.rawValue:
                sheetModalForGroupControl = false
            default:
                return
            }
            
        } label: {
            Image(systemName: imageName)
                .foregroundColor(.mint)
        }
    }
    
    @ViewBuilder
    func setDeleteButton() -> some View {
        Spacer()
        Button {
            mainViewModel.deleteData(collection: CollectionName.groupList.rawValue, comparisonTarget: selectedGroup)
        } label: {
            Image(systemName: GroupImageName.minusCircle.rawValue)
                .resizable()
                .bold()
        }
        .frame(width: 25, height: 25)
        .foregroundColor(.red)
        .padding(.trailing, 4)
    }
}

//MARK: - Function
extension FloatingViewForGroupControl {
    private func setGroupData() -> Dictionary<String, Any> {
        groupData["name"] = selectedGroup
        groupData["color"] = selectedColor.toHexString()
        
        return groupData
    }
}
//#Preview {
//    FloatingViewForGroupUpdate()
//}
