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
        TabBarView(nomeRua: $nomeRua, coordRua: $coordRua)
    }
}


