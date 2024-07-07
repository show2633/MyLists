//
//  CustomNavigationLink.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/7/24.
//

import SwiftUI

// 커스텀 NavigationLink 생성
struct CustomNavigationLink<Content>: View where Content: View {
    let content: () -> Content
    let imageName: String
    let viewName: String
    let width: CGFloat
    let height: CGFloat
    
    init(imageName: String = "",
         viewName: String = "",
         width: CGFloat = CGFloat.zero,
         height: CGFloat = CGFloat.zero,
         @ViewBuilder content: @escaping () -> Content) {
        self.imageName = imageName
        self.viewName = viewName
        self.content = content
        self.width = width
        self.height = height
    }
    
    var body: some View {
        NavigationLink(destination: destinationView()) {
            Image(systemName: imageName)
                .frame(width: self.width, height: self.height)
                .imageScale(.large)
                .font(.largeTitle)
                .foregroundColor(.mint)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 6))
                .shadow(radius: 10)
        }
    }
    
    // NavigationLink 목적지 설정
    @ViewBuilder
    private func destinationView() -> some View {
        switch viewName {
        case "assignment":
            AssignmentView()
        case "workOut":
            WorkOutView()
        case "daily":
            DailyView()
        case "meet":
            MeetView()
        default:
            MainView()
        }
    }
}
