//
//  LocationSearchActivationView.swift
//  Uber2.0
//
//  Created by Gustavo Zahorcsak Matias Silvano on 08/05/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        ZStack{
            HStack {
                
                Text(" Digitar endereço")
                    .foregroundColor(Color.gray)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 64, height: 50)
            .background(
                Rectangle()
                    .fill(Color(.systemGray4))
                    .shadow(color: .black, radius: 6))
                    .cornerRadius(10)
            Spacer()
        }
            .padding(.top, -200)
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
