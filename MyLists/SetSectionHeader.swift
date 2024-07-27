//
//  SetSectionHeader.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct SetSectionHeader: View {
    @State var title: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.custom(FontName.saemaul.rawValue, size: 24))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SetSectionHeader()
}
