//
//  SetColorPicker.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/25/24.
//

import SwiftUI

struct SetColorPicker: View {
    @Binding var selectedColor: Color
    
    var body: some View {
        ColorPicker("", selection: $selectedColor)
            .frame(width: 0, alignment: .center)
            .padding()
    }
}

#Preview {
    SetColorPicker(selectedColor: .constant( Color.black))
}
