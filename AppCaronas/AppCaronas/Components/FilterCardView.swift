//
//  FilterCardView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 12/05/23.
//

import SwiftUI

struct FilterCardView: View {
    var body: some View {
        VStack(spacing: -6) {
            ZStack {
                Rectangle()
                    .frame(height: 300)
                    .cornerRadius(22)
                    .padding()
                    .foregroundColor(.white)
                VStack(spacing: 30) {
                    WeekButtonView(size: 30)
                    RouteSelectionView()
                    TimeSelectionView()
                    TransportView()
                }
            }
            NavigationLink {
                FilteredGroupView()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 50)
                        .foregroundColor(.blue)
                    Text("Buscar")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
    }
}

struct FilterCardView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCardView()
            .background(Color(.red))
    }
}
