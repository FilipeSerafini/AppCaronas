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

