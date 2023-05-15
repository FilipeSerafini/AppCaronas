//
//  AddressCardView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 14/05/23.
//

import SwiftUI

struct AddressCardView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.lightGray))
                    .frame(width: 20)
                    
                Text(title)
                    .foregroundColor(Color(.lightGray))
            }
            HStack {
                Text("" + subtitle)
            }
        }
    }
}

struct AddressCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddressCardView(title: "Apple Academy", subtitle: "Avenida Ipiranha, 2425")
    }
}
