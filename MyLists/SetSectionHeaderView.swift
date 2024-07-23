//
//  SetSectionHeader.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct SetSectionHeaderView: View {
    @State var title: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.custom("HS새마을체", size: 24))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SetSectionHeaderView()
}
