//
//  CombinadosView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct CombinadosView: View {
    @State var person: Person
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(person.groups, id: \.self){ group in
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
