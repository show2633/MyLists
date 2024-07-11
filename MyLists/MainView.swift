//
//  ContentView.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 6/25/24.
//

import SwiftUI

enum ListsType: String {
    case signature = "signature.ar"
    case workOut =  "dumbbell.fill"
    case daily = "cup.and.saucer.fill"
    case meet = "figure.2"
}

struct MainView: View {
    var tc = TestViewModel()
    var listsType: [ListsType] = [
        ListsType.signature,
        ListsType.workOut,
        ListsType.daily,
        ListsType.meet
    ]
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                Header()
                
                LazyVStack {
                    VStack {
                        Spacer()
                            .frame(height: geo.size.height * 0.05)
                        
                        HStack {
                            Spacer()
                            
                            VStack{
                                CustomNavigationLink(imageName: ListsType.signature.rawValue, viewName: "assignment", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                                Text("ASSIGNMENT")
                                    .bold()
                                    .frame(width: geo.size.width * 0.3)
                            }
                            
                            Spacer()
                                .frame(width: geo.size.width * 0.15)
                            
                            VStack{
                                CustomNavigationLink(imageName: ListsType.workOut.rawValue, viewName: "workOut", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                                Text("WORK OUT")
                                    .bold()
                                    .frame(width: geo.size.width * 0.3)
                            }
                            
                            Spacer()
                        } // HStack
                        
                        Spacer()
                            .frame(height: geo.size.height * 0.05)
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                CustomNavigationLink(imageName: ListsType.daily.rawValue, viewName: "daily", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                                Text("DAILY")
                                    .bold()
                                    .frame(width: geo.size.width * 0.3)
                            }
                            
                            Spacer()
                                .frame(width: geo.size.width * 0.15)
                            
                            VStack {
                                CustomNavigationLink(imageName: ListsType.meet.rawValue, viewName: "meet", width: geo.size.width * 0.2, height: geo.size.height * 0.1) {}
                                Text("MEET")
                                    .bold()
                                    .frame(width: geo.size.width * 0.3)
                            }
                            
                            Spacer()
                        } // HStack
                        
                        Spacer()
                    } // VStack
                    .frame(height: geo.size.height * 0.4)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.mint)
                    )
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.02)
                } // LazyStack
                .padding()
                .frame(width: geo.size.width, height: geo.size.height * 0.45)
                
                Spacer()
                    .frame(height: geo.size.height * 0.00)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("가나다라마바사아자차카타파하")
                            .bold()
                        
                        Spacer()
                    }
                    .frame(alignment: .center)
                    
                    Spacer()
                }
                .frame(height: geo.size.height * 0.20, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.mint)
                )
                
                Spacer()
                    .frame(height: geo.size.height * 0.035)
                
                VStack {
                    TabView {
                        ForEach(listsType, id: \.self) { type in
                            ToDoPreviewView(listRawValue: type.rawValue)
                                .tabItem {
                                    Image(systemName: type.rawValue)
                                }
                        }
                    }
                    .background(Color.clear)
                    .tint(Color.mint)
                }
                .frame(height: geo.size.height * 0.25, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.mint)
                )
            } // NavigationStack
            .padding()
            .frame(height: geo.size.height + 80 )
            .ignoresSafeArea()
        } // GeometryReader
    } // body
}

#Preview {
    MainView()
}
