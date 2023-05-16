//
//  HomeView.swift
//  Uber2.0
//
//  Created by Gustavo Zahorcsak Matias Silvano on 08/05/23.
//

import SwiftUI
import MapKit

struct Endereco: Hashable {
    var nome = ""
    var location = CLLocationCoordinate2D()
    var destino = CLLocationCoordinate2D()

    func hash(into hasher: inout Hasher) {
        hasher.combine(nome)
        hasher.combine(location.latitude)
        hasher.combine(location.longitude)
        hasher.combine(destino.latitude)
        hasher.combine(destino.longitude)
    }

    static func == (lhs: Endereco, rhs: Endereco) -> Bool {
        return lhs.nome == rhs.nome &&
            lhs.location.latitude == rhs.location.latitude &&
            lhs.location.longitude == rhs.location.longitude &&
            lhs.destino.latitude == rhs.destino.latitude &&
            lhs.destino.longitude == rhs.destino.longitude
    }
}

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State var controle = 0
    @State var conjunto = Set<Endereco>()
    @State var atual : Set<String> = []
    
    @State var enderecos : [Endereco] = [Endereco(nome: "Rua Santa tecla 11", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.00056, longitude: -51.15247)), Endereco(nome: "Rua 12 de Outubro, 109", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.06713, longitude: -51.19049)), Endereco(nome: "Rua Dr Telmo Vergara 155", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.05974, longitude: -51.15785)), Endereco(nome: "Rua Joao Alfredo 277", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.03983, longitude: -51.22669)), Endereco(nome: "Zona Sul", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.08996, longitude: -51.23896)), Endereco(nome: "Rua Humaita", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -29.98755, longitude: -51.19356)), Endereco(nome: "Rua Paulo Blaschke", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.01371, longitude: -51.13257)), Endereco(nome: "Rua Quintino Bocaiúva, 1394", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.03056, longitude: -51.19681)), Endereco(nome: "Rua Vidal De Negreiros 270 Carrefour", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.06233, longitude: -51.16968)), Endereco(nome: "Rua Pedro Boticario Centro 311", location: CLLocationCoordinate2D(latitude: -30.05985, longitude: -51.17175), destino: CLLocationCoordinate2D(latitude: -30.07170, longitude: -51.20056))]
    var body: some View {
        ZStack(alignment: .top) {
            
            UberMapViewRepresentable(enderecos: $enderecos, mapState: $mapState, controle: $controle, conjunto: $conjunto, atual: $atual)
                .ignoresSafeArea()
            VStack{
                ForEach(Array(atual), id: \.self) { value in
                    Text("\(atual.count)")
                    Text("\(value)\n")
                }
            }.background(.white)
            if (mapState == .searchingForLocation) {
                LocationSearchView(mapState: $mapState)
            } else if mapState == .noInput {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            mapState = .searchingForLocation
                        }
                    }
            }
            
            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}