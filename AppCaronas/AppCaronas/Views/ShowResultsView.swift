//
//  ShowResultsView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 19/05/23.
//

import SwiftUI

struct ShowResultsView: View {
    
    @Binding var searchedAddress: String
    
    @EnvironmentObject var gc: RideGroupCRUD
    
    var searchedGroups: [RideGroup] {
        gc.groups.filter({ $0.finalAdress == searchedAddress})
    }
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                ForEach(searchedGroups, id: \.self){ group in
                    NavigationLink{
                        GroupDetailsView(group: group)
                    }label: {
                        GroupRow(group: group)
                            .foregroundColor(.black)
                            .padding(.bottom, -24)
                    }
                }
            }
            .navigationTitle("Grupos encontrados")
        }
        
    }
}

//struct ShowResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowResultsView(searchedAddress: $)
//    }
//}
