//
//  TabBarView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct TabBarView: View {
    @Binding var nomeRua : String

    var body: some View {
        TabView {
            FeedView(nomeRua: $nomeRua)
                .tabItem {
                    VStack {
                        Label("Ofertas", systemImage: "person.2.wave.2.fill")
                    }
                }
            
            BuscarView(nomeRua: $nomeRua)
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


