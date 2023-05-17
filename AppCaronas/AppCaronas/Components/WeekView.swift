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
//        HStack(spacing: 10) {
//            ForEach(0..<group.week.selected.count, id: \.self) { i in
//                ZStack {
//                    Circle()
//                        .frame(width: CGFloat(size + 4))
//                        .foregroundColor(group.week.selected[i] ? .green : Color(.lightGray))
//                    Image(systemName: "\(group.week.letters[i]).circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: CGFloat(size))
//                        .foregroundColor(Color(.lightGray))
//                        .background(Color(.black))
//                        .clipShape(Circle())
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//        }
        HStack(spacing: 10) {
            ForEach(0..<group.daysOfTheWeek.count, id: \.self) { i in
                ZStack {
                    Image(systemName: "\(letters[i]).circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: CGFloat(size))
//                        .foregroundColor(group.daysOfTheWeek[i] ? .green : Color(.lightGray))
                        .background(Color(.black))
                        .clipShape(Circle())

                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(group: g1, size: 40)
    }
}
