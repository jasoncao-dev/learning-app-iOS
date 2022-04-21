//
//  Learning_AppApp.swift
//  Learning App
//
//  Created by Jason Cao on 4/20/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
