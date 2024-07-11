//
//  DailyView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/3/24.
//

import SwiftUI

struct DailyView: View {
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
                    Text("DailyView")
                        
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
        .navigationTitle("DAILY")
    }
}

#Preview {
    DailyView()
}
