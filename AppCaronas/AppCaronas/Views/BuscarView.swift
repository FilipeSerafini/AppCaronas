//
//  BuscarView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 13/05/23.
//
import SwiftUI
import MapKit

struct BuscarView: View {
    @StateObject var locationViewModel = LocationSearchViewModel()
    @Binding var nomeRua : String
    @Binding var coordRua : CLLocationCoordinate2D
    
//    @State var selectedDate = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!
    
    @State var selectedDay: [Bool] = [false, false, false, false, false, false, false]
    let letters: [String] = ["s","t","q","q","s","s","d"]
    
    @State var selectedType: RideType = .car
    @State private var selectedHour = 2
    
    @Namespace private var animation
    @State var swapped = false
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    VStack (alignment: .center){
                        HStack{
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.black)
                                .coordinateSpace(name: "start")
                                .onTapGesture {
                                    withAnimation {
                                        swapped.toggle()
                                    }
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
                                if (!swapped) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 82, height: 24)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.black, lineWidth: 1)
                                            )
                                        Text("Academy")
                                    }
                                    .matchedGeometryEffect(id: "academy", in: animation)
                                    //                                NavigationLink {
                                    //                                    AddressSearchView()
                                    //                                } label: {
                                    //                                    ZStack(alignment: .leading) {
                                    //                                        RoundedRectangle(cornerRadius: 5)
                                    //                                            .frame(width: 260, height: 25)
                                    //                                            .foregroundColor(Color(.lightGray))
                                    //                                        Text(" Para")
                                    //                                            .foregroundColor(.black)
                                    //                                    }
                                    //                                }
                                    NavigationLink{
                                        HomeView(selecao: true, nomeRua: $nomeRua, coordRua: $coordRua).environmentObject(locationViewModel)
                                    }label: {
                                        Text(nomeRua == " " ? "Para" : nomeRua)
                                    }
                                    .matchedGeometryEffect(id: "addressBar", in: animation)
                                } else {
                                    //                                NavigationLink {
                                    //                                    AddressSearchView()
                                    //                                } label: {
                                    //                                    ZStack(alignment: .leading) {
                                    //                                        RoundedRectangle(cornerRadius: 5)
                                    //                                            .frame(width: 260, height: 25)
                                    //                                            .foregroundColor(Color(.lightGray))
                                    //                                        Text(" De")
                                    //                                            .foregroundColor(.black)
                                    //                                    }
                                    //                                }
                                    NavigationLink{
                                        HomeView(selecao: true, nomeRua: $nomeRua, coordRua : $coordRua).environmentObject(locationViewModel)
                                    }label: {
                                        Text(nomeRua == " " ? "De" : nomeRua)
                                    }
                                    .matchedGeometryEffect(id: "addressBar", in: animation)
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 82, height: 24)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.black, lineWidth: 1)
                                            )
                                        Text("Academy")
                                    }
                                    .matchedGeometryEffect(id: "academy", in: animation)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Text("Dia(s):")
                }
                VStack{
                    //                WeekButtonView(size: 30)
                    HStack(spacing: 10) {
                        ForEach(0..<letters.count, id: \.self) { i in
                            Button {
                                selectedDay[i].toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: CGFloat(30 + 4))
                                        .foregroundColor(selectedDay[i] ? .green : Color(.lightGray))
                                    Image(systemName: "\(letters[i]).circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: CGFloat(30))
                                        .foregroundColor(Color(.lightGray))
                                        .background(Color(.black))
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                    
                    TimeSelectionView()
                    
                    
                    
                    
                   
                    
                    
                }
                
                .navigationTitle("Criar Companhia")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}
