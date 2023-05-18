//
//  TabBarView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI
import MapKit

struct TabBarView: View {
    @Binding var nomeRua : String
    @Binding var coordRua : CLLocationCoordinate2D

    var body: some View {
        TabView {
            FeedView(nomeRua: $nomeRua)
                .tabItem {
                    VStack {
                        Label("Ofertas", systemImage: "person.2.wave.2.fill")
                    }
                }
            
            BuscarView(nomeRua: $nomeRua, coordRua: $coordRua)
                .tabItem {
                    VStack {
                        Label("Buscar", systemImage: "magnifyingglass")
                    }
                }
            
            CombinadosView(person: p1)
                .tabItem {
                    VStack {
                        Label("Combinados", systemImage: "hand.raised.fill")
                    }
                }
            
            PerfilView(person: p1)
                .tabItem {
                    VStack {
                        Label("Perfil", systemImage: "person")
                    }
                }
        }
    }
}


