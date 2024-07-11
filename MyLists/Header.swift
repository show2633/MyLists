//
//  Header.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import SwiftUI

// Header 생성
struct Header: View {
    var body: some View {
        VStack {
            Text("HyunWoo's List")
                .bold()
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
#Preview {
    Header()
}
