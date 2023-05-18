//
//  CombinadosView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct CombinadosView: View {
    @EnvironmentObject var gc: RideGroupCRUD
    @State var person: Person
    
    var myGroups: [RideGroup] {
        gc.groups.filter({ $0.members.contains(where: { $0 == UserCRUD.getUserID() }) })
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(myGroups, id: \.self){ group in
                    GroupRow(group: group)
                }
            }
            .navigationTitle("Combinados")
        }
        
    }
}

struct CombinadosView_Previews: PreviewProvider {
    static var previews: some View {
        CombinadosView(person: p1)
    }
}
