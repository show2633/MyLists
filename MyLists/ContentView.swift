//
//  ContentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    Spacer()
                        .frame(height: geo.size.height * 0.17)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack{
                            CustomNavLink(imageName: "signature.ar", viewName: "Assignment", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                            Text("ASSIGNMENT")
                                .bold()
                                .frame(width: geo.size.width * 0.3)
                        }
                        
                        Spacer()
                        
                        VStack{
                            CustomNavLink(imageName: "dumbbell.fill", viewName: "Work Out", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                            Text("WORK OUT")
                                .bold()
                                .frame(width: geo.size.width * 0.3)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                        .frame(height: geo.size.height * 0.15)
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            CustomNavLink(imageName: "cup.and.saucer.fill", viewName: "Daily", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                            Text("DAILY")
                                .bold()
                                .frame(width: geo.size.width * 0.3)
                        }
                        
                        Spacer()
                        
                        VStack {
                            CustomNavLink(imageName: "figure.2", viewName: "Meet", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                            Text("MEET")
                                .bold()
                                .frame(width: geo.size.width * 0.3)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            
        }
    }
}

// MVVM : Model View ViewModel 

struct AssignmentView: View {
    var body: some View {
        Text("t1")
            .navigationTitle("ASSIGNMENT")
            .font(.system(size: 20))
    }
}

struct WorkOutView: View {
    var body: some View {
        Text("t2")
            .navigationTitle("WORK OUT")
    }
}

struct DailyView: View {
    var body: some View {
        Text("t3")
            .navigationTitle("DAILY")
    }
}

struct MeetView: View {
    var body: some View {
        Text("t4")
            .navigationTitle("MEET")
    }
}



struct CustomNavLink<Content>: View where Content: View {
    @State var firstNaviLinkActive: Bool = false
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
        .navigationTitle("HW'S LISTS")
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        switch viewName {
        case "Assignment":
            AssignmentView()
        case "Work Out":
            WorkOutView()
        case "Daily":
            DailyView()
        case "Meet":
            MeetView()
        default:
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
