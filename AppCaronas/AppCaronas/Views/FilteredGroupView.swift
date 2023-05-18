//
//  FilteredGroupView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 15/05/23.
//

import SwiftUI
import MapKit

struct FilteredGroupView: View {
    @Binding var nomeRua : String
    @Binding var coordRua : CLLocationCoordinate2D
    var body: some View {
        BuscarView(nomeRua: $nomeRua, coordRua: $coordRua)
    }
}


