//
//  CreateGroupView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 16/05/23.
//

import SwiftUI



struct CreateGroupView: View {
    @State var selectedDate = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!
    
    @State var selectedDay: [Bool] = [false, false, false, false, false, false, false]
    let letters: [String] = ["s","t","q","q","s","s","d"]
    
    @State var selectedType: RideType = .car
    @State private var selectedHour = 2
    
    @Namespace private var animation
    @State var swapped = false
    
    @State var location = ""
    
    var body: some View {
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
                                TextField("Para", text: $location)
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
                                TextField("De", text: $location)
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
                
                DatePicker("Select Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .padding()
                
                
                List {
                    Picker("Tipo de companhia", selection: $selectedType) {
                        Text("Carro").tag(RideType.car)
                        Text("Moto").tag(RideType.motorcycle)
                        Text("Uber").tag(RideType.uber)
                        Text("Ônibus").tag(RideType.bus)
                        Text("Bicicleta").tag(RideType.bicycle)
                        Text("Caminhada").tag(RideType.walk)
                    }
                    //                            .pickerStyle(.navigationLink)
                    
                    Picker("Número máximo de participantes", selection: $selectedHour) {
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                        Text("6").tag(6)
                        Text("7").tag(7)
                        Text("8").tag(8)
                        Text("9").tag(9)
                        Text("10").tag(10)
                        
                    }
                    
                }
                .listStyle(.inset)
                
                Button{
                    
                }label: {
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 100, height: 50)
                        Text("Criar")
                            .foregroundColor(.white)
                        
                    }
                }
                .padding()
                //                .listStyle(.inset)
                
                
            }
            
            .navigationTitle("Criar Companhia")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
