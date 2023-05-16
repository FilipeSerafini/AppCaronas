//
//  TransportView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 13/05/23.
//

import SwiftUI

struct TransportView: View {
    @State var selected: [Bool] = [false, false, false, false, false, false]
    let symbolList: [String] = [
        "iphone.radiowaves.left.and.right",
        "car.fill",
        "bicycle",
        "bus.fill",
        "figure.walk"
    ]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<symbolList.count, id: \.self) { i in
                ZStack {
                    Circle()
                        .foregroundColor(selected[i] ? Color(.lightGray) : .white)
                        .frame(width: 38)
                    Image(systemName: symbolList[i])
                        .foregroundColor(.black)
                }
                .onTapGesture {
                    selected[i].toggle()
                }
            }
        }
    }
}


struct TransportView_Previews: PreviewProvider {
    static var previews: some View {
        TransportView()
    }
}
