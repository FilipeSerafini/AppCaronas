//
//  LocationSearchResultCell.swift
//  Uber2.0
//
//  Created by Igor Dourado on 09/05/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
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
                        HStack() {
                            Text("" + subtitle)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: UIScreen.main.bounds.width)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Starbucks", subtitle: "123")
    }
}
