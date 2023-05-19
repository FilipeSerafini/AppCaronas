//
//  WeekView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 12/05/23.
//

import SwiftUI



struct WeekView: View {
//    @State var selected: [Bool] = [false, false, false, false, false, false, false]
    var group: RideGroup
    let letters: [String] = ["s","t","q","q","s","s","d"]
    let size: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<group.daysOfTheWeek.count, id: \.self) { i in
                ZStack {
                    Circle()
                        .frame(width: CGFloat(Double(size) + 4.5))
                        .foregroundColor((group.daysOfTheWeek[i] == 1) ? .green : Color(.systemGray5))
                    
                    Circle()
                        .frame(width: CGFloat(size)-2)
                        .foregroundColor(.black)
                    
                    Image(systemName: "\(letters[i]).circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: CGFloat(size))
                        .foregroundColor(Color(.systemGray5))
                    
                }
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(group: g1, size: 40)
    }
}
