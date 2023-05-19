//
//  PerfilView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 11/05/23.
//

import SwiftUI

struct PerfilView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.vertical, 30)
                    Text("Nome")
                        .foregroundColor(Color(.black).opacity(0.6))
                    Text(UserCRUD.getUserName())
                        .foregroundColor(Color(.lightGray))
                    Divider()
                    Text("Número de telefone")
                        .foregroundColor(Color(.black).opacity(0.6))
                    Text(UserCRUD.getUserPhone())
                        .foregroundColor(Color(.lightGray))
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
        PerfilView()
    }
}
