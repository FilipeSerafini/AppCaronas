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
                if group.type != .motorcycle{
                    group.type.typeImage
                }else{
                    group.type.typeImage
                        .resizable()
                        .frame(width: 20, height: 18)
                }
                if (group.initialAdress == "Academy") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 82, height: 24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray), lineWidth: 1)
                            )
                        Text(group.initialAdress)
                            .lineLimit(1)
                            .foregroundColor(Color(.systemGray))
                    }
                    Image(systemName: "arrow.right")
                    Text(group.finalAdress)
                        .lineLimit(1)
                } else {
                    Text(group.initialAdress)
                        .lineLimit(1)
                    Image(systemName: "arrow.right")
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 82, height: 24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray), lineWidth: 1)
                            )
                        Text(group.finalAdress)
                            .lineLimit(1)
                            .foregroundColor(Color(.systemGray))
                    }
                }
                Spacer()
                Image(systemName: "arrow.2.squarepath")
            }
            .padding(.top)
            .padding(.horizontal)
//            .background(Color(.red))
            //            Divider()
            HStack{
                VStack{
                    HStack{
                        WeekView(group: group, size: 20)
//                            .padding(.leading)
                        Spacer()
                        
                    }
                    Spacer()
                    HStack{
                        Text(group.hour)
                            .padding(.leading, 3)
                        Spacer()
                        HStack{
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(.green)
                            Text("\(group.members.count)")
                        }
                    }
//                    .background(Color(.red))
                }
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            //            .background(Color(.red))
            
        }
        .frame(width: 350, height: 120)
        .background()
        .cornerRadius(22)
        .shadow(color: Color(.lightGray) ,radius: 5)
        .font(.subheadline)
        .padding()
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow(group: g1)
    }
}
