//
//  GroupDetailsView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 15/05/23.
//

import SwiftUI

struct GroupDetailsView: View {
    var group: Group
    var body: some View {
        ScrollView{
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .ignoresSafeArea(.all)
                VStack (alignment: .center){
                    HStack {
                        VStack{
                            Spacer()
                            Text(group.time)
                            Spacer()
                        }
                        
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                            VStack(spacing: 4) {
                                Circle()
                                    .frame(width: 2)
                                Circle()
                                    .frame(width: 2)
                                Circle()
                                    .frame(width: 2)
                            }
                            .padding(.top, 4)
                            .padding(.bottom, 4)
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.blue)
                                .coordinateSpace(name: "end")
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            if group.initialAdress == "Academy"{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 82, height: 24)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    Text("Academy")
                                        .foregroundColor(.gray)
                                }
                                
                                ZStack{
                                    Text(group.finalAdress)
                                    
                                }
                            }else{
                                ZStack{
                                    Text(group.finalAdress)
                                    
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 82, height: 24)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                            
                                        )
                                    Text("Academy")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(30)
                }
            }
            
            Divider()
                .frame(height: 50)
            
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                VStack{
                    
                    
                    WeekView(group: group,size: 30)
                    
                    Text("\(group.type.typeImage) \(group.type.descriptionDetailed)")
                    
                    if group.type == .car || group.type == .motorcycle || group.type == .uber{
                        if group.price == true{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 30)
                                Text("$ Esta é uma carona com custos a dividir")
                            }
                        }
                        
                    }
//                    Text(group.price ? "Esta é um" : )
                    
                }
                .padding(.vertical, 20)
            }
            
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                VStack{
                    HStack{
                        Text("Participantes")
                        Spacer()
                        Image(systemName: "person.fill.checkmark")
                            .foregroundColor(.green)
                        Text("\(group.members.count+1)")
                    }
                    .padding(.bottom, 15)
                    HStack{
                        VStack{
                            Image(systemName: group.leader.photo)
                            Text(group.leader.name)
                        }
                        .padding(.horizontal, 10)
                        ForEach(group.members, id: \.self){ member in
                            VStack{
                                Image(systemName: "person.circle")
                                Text(member)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }.padding()
                
            }
            
            
            
        }
        .navigationBarTitle(group.initialAdress)
        .navigationBarTitleDisplayMode(.inline)
//        .background(.gray)
        .toolbar{
            Button{
                
            }label: {
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .frame(width: 25, height: 25)
//                    .padding(.top, 50)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 30)
            }
            
        }
    }
}

struct GroupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailsView(group: g1)
    }
}
