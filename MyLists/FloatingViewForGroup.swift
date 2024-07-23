//
//  FloatingViewForGroup.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct FloatingViewForGroup: View {
    @State var groupName: String = ""
    @Binding var sheetModalForGroup: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: SetSectionHeaderView(title: "Group")) {
                        setGroup()
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
        TextField("그룹명을 입력 해 주세요", text: $groupName)
            .font(Font.custom("HS새마을체", size: 17))
    }
    
    @ViewBuilder
    func setToolbarButton(imageName: String) -> some View {
        Button {
            switch imageName {
            case "square.and.arrow.up":
                sheetModalForGroup = false
            case "xmark.square":
                sheetModalForGroup = false
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
//    FloatingViewForGroup()
//}
