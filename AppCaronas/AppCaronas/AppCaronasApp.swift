//
//  AppCaronasApp.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI
import MapKit

@main
struct AppCaronasApp: App {
    @StateObject var uc: UserCRUD = UserCRUD()
    @State var nomeRua: String = " "
    @State var coordRua: CLLocationCoordinate2D = CLLocationCoordinate2D()

    var body: some Scene {
        WindowGroup {
            ContentView(nomeRua: $nomeRua, coordRua: $coordRua)
        }
    }
}
