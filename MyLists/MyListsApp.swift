//
//  MyListsApp.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 6/25/24.
//

import SwiftUI
import Firebase

@main
struct MyListsApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
