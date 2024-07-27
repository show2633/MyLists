//
//  FloatingViewForGroup.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct FloatingViewForGroupCreate: View {
    @StateObject var mainViewModel:MainViewModel
    @State var groupName: String = ""
    @State var selectedColor: Color = Color.black
    @State var groupData: Dictionary<String, Any> = Dictionary()
    @Binding var sheetModalForGroupCreate: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: SetSectionHeader(title: "Group")) {
                        setGroup()
                    }
                    
                    Section(header:SetSectionHeader(title: "Color")) {
                        SetColorPicker(selectedColor: $selectedColor)
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
        }
    }
    

}

//MARK: - ViewBuilder
extension FloatingViewForGroupCreate {
        @ViewBuilder
        func setGroup() -> some View {
            TextField("그룹명을 입력 해 주세요", text: $groupName)
                .font(Font.custom(FontName.saemaul.rawValue, size: 17))
        }
        
        @ViewBuilder
        func setToolbarButton(imageName: String) -> some View {
            Button {
                switch imageName {
                case SetToolBarButtonImageName.squareArrowUp.rawValue:
                    mainViewModel.createData(collection: CollectionName.groupList.rawValue, dataForCreate: setGroupData())
                    sheetModalForGroupCreate = false
                case SetToolBarButtonImageName.xmarkSquare.rawValue:
                    sheetModalForGroupCreate = false
                default:
                    return
                }
                
            } label: {
                Image(systemName: imageName)
                    .foregroundColor(.mint)
            }
        }
}

//MARK: - Function
extension FloatingViewForGroupCreate {
    private func setGroupData() -> Dictionary<String, Any> {
        groupData["name"] = groupName
        groupData["color"] = selectedColor.toHexString()
        
        return groupData
    }
}
//#Preview {
//    FloatingViewForGroupCreate()
//}
