//
//  AddressSearchView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 14/05/23.
//

import SwiftUI

struct AddressSearchView: View {
    @State var location: String = ""
    
    var body: some View {
        VStack {
            TextField("Pesquisar no mapa", text: $location)
                .frame(height: 40)
                .background(Color(.lightGray).opacity(0.4))
                .foregroundColor(.black)
                .cornerRadius(6)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView()
    }
}
