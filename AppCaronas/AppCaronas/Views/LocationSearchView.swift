//
//  LocationSearchView.swift
//  Uber2.0
//
//  Created by Gustavo Zahorcsak Matias Silvano on 09/05/23.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    @State private var startLocationText: String = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var vezes : Int
    @Binding var nomeRua : String
    @Binding var coordRua : CLLocationCoordinate2D

    
    var body: some View {
        VStack {
            // header view
            HStack {
                
                VStack {
                    
                    TextField(" Para onde?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .cornerRadius(10)
                        .padding(.trailing)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            .frame(height: 50)
            Spacer()
            Divider()
                .padding(.vertical)
            
            // list view
            
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                print(result.title)
                                nomeRua = result.title//Guarda o Nome Da Rua
                                let searchRequest = MKLocalSearch.Request(completion: result)
                                                let search = MKLocalSearch(request: searchRequest)
                                                search.start { response, error in
                                                    if let mapItem = response?.mapItems.first {
                                                        print("COORDINATES:", mapItem.placemark.coordinate)
                                                        coordRua = mapItem.placemark.coordinate // Assign the coordinates to the coordRua variable
                                                    }
                                                }
                                viewModel.selectedLocation(result)
                                
                                mapState = .locationSelected
                                vezes += 1
                                
                                //aqui
                                
                            }
                        Divider().padding(.horizontal)
                    }
                }
            }
            
        }
        .background(.white)
    }
}

