//
//  AppCaronasApp.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI

@main
struct AppCaronasApp: App {
    @State var nomeRua: String = " "

    var body: some Scene {
        WindowGroup {
            ContentView(nomeRua: $nomeRua)
        }
    }
}
