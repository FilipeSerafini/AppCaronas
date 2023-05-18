//
//  GroupRow.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 09/05/23.
//

import SwiftUI

struct GroupRow: View {
    
    var group: RideGroup
    
    var body: some View {
        VStack{
            HStack{
                group.type.typeImage
                Divider()
                Text(group.initialAdress)
                    .lineLimit(1)
                Image(systemName: "arrowshape.right.fill")
                Text(group.finalAdress)
                    .lineLimit(1)
                Divider()
                Image(systemName: "arrow.2.squarepath")
            }
            .padding(.top)
            .padding(.horizontal)
            Divider()
            HStack{
                VStack{
                    HStack{
                        WeekView(group: group, size: 15)
                            .padding(.leading)
                        Spacer()
                        
                    }
                    Spacer()
                    HStack{
                        Text(group.hour)
                            .padding(.leading)
                        Spacer()
                    }
                }
                Spacer()
                HStack{
                    Image(systemName: "person.fill.checkmark")
                        .foregroundColor(.green)
                    Text("\(group.members.count + 1)")
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .frame(width: 350, height: 150)
        .background()
        .cornerRadius(20)
        .shadow(color: .black,radius: 3)
        .font(.subheadline)
        .padding()
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow(group: g1)
    }
}
