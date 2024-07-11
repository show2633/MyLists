//
//  WorkOutView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/3/24.
//

import SwiftUI

struct WorkOutView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Button {
                    
                } label: {
                    Text("+   ")
                        .font(.system(size: 50))
                        .frame(width:geo.size.width ,height: geo.size.height * 0.05, alignment: .trailing)
                        .foregroundColor(.mint)
                        .bold()
                }
                VStack{
                    Text("WorkOutView")
                        
                }
                .frame(width: geo.size.width, height: geo.size.height * 0.90, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.mint)
                )
            }
        }
        .navigationTitle("WORK OUT")
    }
}

#Preview {
    WorkOutView()
}
