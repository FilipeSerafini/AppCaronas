//
//  PerfilView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 11/05/23.
//

import SwiftUI

struct PerfilView: View {
    
    @State var person: Person
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.vertical, 30)
                    Text("Nome")
                        .foregroundColor(.gray)
                    Text(person.name)
                    Divider()
                    Text("Número de telefone")
                        .foregroundColor(.gray)
                    Text(person.number)
                    Divider()
                    Text("E-mail")
                        .foregroundColor(.gray)
                    Text(person.email)
                    Divider()
                    
                }
                .navigationTitle("Perfil")
                .padding(.horizontal, 40)
                Spacer()
            }
        }
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView(person: p1)
    }
}
