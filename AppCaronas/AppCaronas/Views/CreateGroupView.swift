//
//  CreateGroupView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 12/05/23.
//

import SwiftUI
import CloudKit

struct CreateGroupView: View {
    
//    @State var rideType: RideType
    @State var initialAdress: String = ""
    @State var finalAdress: String = ""
//    @State var leader: String = ""
    @State var maxMembers: String = ""
//    @State var members: [Person]
    @State var time: String = ""
    @State var monday: Bool = false
    @State var tuesday: Bool = false
    @State var wednesday: Bool = false
    @State var thursday: Bool = false
    @State var friday: Bool = false
    @State var saturday: Bool = false
    @State var sunday: Bool = false
    
    var gc = CompGroupCRUD()
    
    
    
    var body: some View {
        VStack {
            TextField("Endereco de partida", text: self.$initialAdress)
                .padding()
            
            TextField("Endereco final", text: self.$finalAdress)
                .padding()
            
            TextField("Numero maximo de membros", text: self.$maxMembers)
                .padding()
            
            TextField("Horario de partida", text: self.$time)
                .padding()
            
            
            Button(action: {
                guard let maxMembers = Int(self.maxMembers) else { return }
                let group = RideGroup(initialAdress: self.initialAdress, finalAdress: self.finalAdress, maxMembers: self.maxMembers, time: self.time)
                
                gc.addGroup(newGroup: group!)
            }, label: {
                Text("Save group on database")
            })
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
