//
//  CombinadosView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct CombinadosView: View {
    @EnvironmentObject var gc: RideGroupCRUD
    
    var userGroups: [RideGroup] {
        gc.groups.filter({ $0.members.contains(where: { $0 == UserCRUD.getUserID() }) })
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(userGroups, id: \.self){ group in
                    NavigationLink{
                        GroupDetailsView(group: group)
                    }label: {
                        GroupRow(group: group)
                            .foregroundColor(.black)
                            .padding(.bottom, -24)
                    }
                }
            }
            .navigationTitle("Combinados")
        }
        
    }
}

struct CombinadosView_Previews: PreviewProvider {
    static var previews: some View {
        CombinadosView()
    }
}
