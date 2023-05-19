//
//  ContentView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI
import MapKit

struct LoginView: View {
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var firstTime: Bool = true
    @State var nomeRua: String
    @State var coordRua: CLLocationCoordinate2D
    
    var body: some View {
        ZStack {
            TabBarView(nomeRua: $nomeRua, coordRua: $coordRua)
            if (firstTime) {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .foregroundColor(Color(.systemGray))
                            .opacity(0.4)
                            .ignoresSafeArea()
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Nome:")
                                
                                TextField("Nome e Sobrenome", text: $name)
                                    .textFieldStyle(.roundedBorder)
                                    .onSubmit {
#if os(iOS)
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
                                    }
                                
                                Text("Número do celular:")
                                
                                HStack {
                                    Text("+55")
                                        .foregroundColor(Color(.systemGray))
                                    TextField("(DDD) 99999-9999", text: $phoneNumber)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom, 30)
                            
                            Button(action: {
                                if (!name.isEmpty && !phoneNumber.isEmpty) {
                                    firstTime = false
                                }
                            }) {
                                Text("Salvar")
                                    .lineLimit(1)
                                    .frame(width: 150, height: 40)
                                    .foregroundColor(.white)
                                    .background(.blue)
                            }
                            .cornerRadius(10)
                            
                        }
                        .frame(width: 350, height: 250)
                        .background(Color(.white))
                        .cornerRadius(14)
                    }
                }
            }
        }
    }
}
