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
            Spacer()
            Text("HyunWoo's List")
                .bold()
            Spacer()
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 30)
        .background(Rectangle().foregroundColor(.white))
    }
}
#Preview {
    Header()
}
