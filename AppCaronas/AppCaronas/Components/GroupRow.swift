//
//  GroupRow.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 09/05/23.
//

import SwiftUI

struct GroupRow: View {
    
    var group: CompGroup
    
    var body: some View {
        VStack{
            HStack{
                group.type.description
                Divider()
                Text(group.initialAdress)
                    .lineLimit(1)
                Image(systemName: "arrowshape.right.fill")
                Text(group.finalAdress)
                    .lineLimit(1)
                Divider()
                Text("Recorrente")
            }
            .padding(.top)
            .padding(.horizontal)
            Divider()
            HStack{
                VStack{
                    HStack{
                        Text(group.monday ? "S" : "_")
                        
                        Text(group.tuesday ? "T" : "_")
                        
                        Text(group.wednesday ? "Q" : "_")
                        
                        Text(group.thursday ? "Q" : "_")
                        
                        Text(group.friday ? "S" : "_")
                        
                        Text(group.saturday ? "S" : "_")
                        
                        Text(group.sunday ? "D" : "_")
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "clock")
                        Text(group.time)
                    }
                }
                Spacer()
                VStack{
                    Text("\(group.members.count + 1) membros")
                    HStack{
                        if(group.members.count <= 2){
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 30,height: 30)
                            
                            ForEach(group.members, id: \.self){ member in
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                
                            }
                            
                        }else{
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .padding(.horizontal, -8)
                            
                            ForEach(group.members, id: \.self){ member in
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .padding(.horizontal, -8)
                            }
                            Text("...")
                                .font(.title)
                            
                        }
                    }
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
