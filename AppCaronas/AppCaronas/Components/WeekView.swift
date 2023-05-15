//
//  WeekView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 12/05/23.
//

import SwiftUI



struct WeekView: View {
    @State var selected: [Bool] = [false, false, false, false, false, false, false]
    let letters: [String] = ["s","t","q","q","s","s","d"]
    let size: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<letters.count, id: \.self) { i in
                Button {
                    selected[i].toggle()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: CGFloat(size + 4))
                            .foregroundColor(selected[i] ? .green : Color(.lightGray))
                        Image(systemName: "\(letters[i]).circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGFloat(size))
                            .foregroundColor(Color(.lightGray))
                            .background(Color(.black))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(size: 40)
    }
}
