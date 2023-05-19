//
//  ContentView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Binding var nomeRua : String
    @Binding var coordRua : CLLocationCoordinate2D
    var body: some View {
        
//        if UserDefaults.standard.string(forKey: "userName") == "No Name" {
//            UserInfoView(nomeRua: $nomeRua, coordRua: $coordRua)
//        } else {
            TabBarView(nomeRua: $nomeRua, coordRua: $coordRua)
//        }
    }
}


