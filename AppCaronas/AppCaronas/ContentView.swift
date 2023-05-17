//
//  ContentView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var nomeRua : String
    var body: some View {
        TabBarView(nomeRua: $nomeRua)
    }
}


