//
//  FilteredGroupView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 15/05/23.
//

import SwiftUI

struct FilteredGroupView: View {
    @Binding var nomeRua : String
    var body: some View {
        BuscarView(nomeRua: $nomeRua)
    }
}


