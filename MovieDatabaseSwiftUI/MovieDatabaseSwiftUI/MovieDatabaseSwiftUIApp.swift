//
//  MovieDatabaseSwiftUIApp.swift
//  MovieDatabaseSwiftUI
//
//  Created by Tiffany Sakaguchi on 6/27/23.
//

import SwiftUI

@main
struct MovieDatabaseSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoviesView()
            }
        }
    }
}
