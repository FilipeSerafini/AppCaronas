//
//  TabBarView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    VStack {
                        Label("Ofertas", systemImage: "person.2.wave.2.fill")
                    }
                }
            
            BuscarView()
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

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
