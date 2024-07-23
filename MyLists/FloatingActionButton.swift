//
//  FloatingActionButton.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct FloatingActionButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()
                .background(Color.mint)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
    }
}

//#Preview {
//    FloatingActionButton()
//}
