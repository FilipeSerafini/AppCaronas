

//
//  CreateGroupView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 16/05/23.
//

import SwiftUI
import MapKit


struct CreateGroupView: View {
    
    let groupOperations: RideGroupCRUD = RideGroupCRUD()
    @Environment(\.dismiss) var dismiss
    
    
    @State var selectedDate = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!
    
    @State var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    @State var selectedType: RideType = .car
    @State var maxMembers: String = "2"
    var nmembers: [String] = ["2","3","4","5","6","7","8","9","10"]
    @State var initalAdress: String = ""
    @State var finalAdress: String = ""
    @State var userID: String = ""
    @State var userName: String = ""
    
    let letters: [String] = ["s","t","q","q","s","s","d"]
    
    @Namespace private var animation
    @State var swapped = false
    
    @StateObject var locationViewModelReserva = LocationSearchViewModel()

    @State var nomeRua = " "
    @State var coordRua = CLLocationCoordinate2D()

    
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
                        
                        VStack(alignment: .leading, spacing: 20) {
                            if (!swapped) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 82, height: 24)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(.gray), lineWidth: 1)
                                        )
                                    Text("Academy")
                                        .foregroundColor(Color(.lightGray))
                                }
                                .matchedGeometryEffect(id: "academy", in: animation)
                                NavigationLink{
                                    HomeView(selecao: false, nomeRua: $nomeRua, coordRua: $coordRua).environmentObject(locationViewModelReserva)
                                }label: {
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color(.systemGray6))
                                            .frame(width: 270,height: 30)
                                            .cornerRadius(10)

                                            Text(nomeRua == " " ? "Para" : nomeRua)
                                            .padding(.trailing, 226)
                                            .foregroundColor(.black)
                                    }
                                }
                                .matchedGeometryEffect(id: "addressBar", in: animation)
                            } else {
                                NavigationLink{
                                    HomeView(selecao: false, nomeRua: $nomeRua, coordRua: $coordRua).environmentObject(locationViewModelReserva)
                                }label: {
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color(.systemGray6))
                                            .frame(width: 270,height: 30)
                                            .cornerRadius(10)
                                        
                                        Text(nomeRua == " " ? "De" : nomeRua)
                                            .padding(.trailing, 226)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .matchedGeometryEffect(id: "addressBar", in: animation)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 82, height: 24)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(.gray), lineWidth: 1)
                                        )
                                    Text("Academy")
                                        .foregroundColor(Color(.lightGray))
                                }
                                .matchedGeometryEffect(id: "academy", in: animation)
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading)
                }
                .padding()
                
                Text("Dia(s):")
                    .padding(.horizontal, 35)
            }
            VStack {
                
                HStack(spacing: 10) {
                    ForEach(0..<letters.count, id: \.self) { i in
                        ZStack {
                            Circle()
                                .frame(width: CGFloat(34.5))
                                .foregroundColor(selectedDays[i] ? .green : Color(.systemGray5))
                            
                            Circle()
                                .frame(width: CGFloat(28))
                                .foregroundColor(.black)
                            
                            Image(systemName: "\(letters[i]).circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: CGFloat(30))
                                .foregroundColor(Color(.systemGray5))
                            
                        }
                        .onTapGesture {
                            selectedDays[i].toggle()
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack{
                    Text("Horário:")
                        .padding(.horizontal, 35)
                        .padding(.top, 25)
                    
                    Spacer()
                }
                DatePicker("Select Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .padding()
                
                HStack {
                    Text("Tipo de companhia")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Tipo de companhia", selection: $selectedType) {
                        Text("Carro").tag(RideType.car)
                        Text("Moto").tag(RideType.motorcycle)
                        Text("Uber").tag(RideType.uber)
                        Text("Ônibus").tag(RideType.bus)
                        Text("Bicicleta").tag(RideType.bicycle)
                        Text("Caminhada").tag(RideType.walk)
                    }
                    .tint(.black)
                    .pickerStyle(.menu)
                }
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
                
                HStack {
                    Text("Número máximo de participantes")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Número máximo de participantes", selection: $maxMembers) {
                        Text("2").tag(nmembers[0])
                        Text("3").tag(nmembers[1])
                        Text("4").tag(nmembers[2])
                        Text("5").tag(nmembers[3])
                        Text("6").tag(nmembers[4])
                        Text("7").tag(nmembers[5])
                        Text("8").tag(nmembers[6])
                        Text("9").tag(nmembers[7])
                        Text("10").tag(nmembers[8])
                    }
                    .tint(.black)
                    .pickerStyle(.menu)
                }
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
                ZStack{
                    HStack{
                        Button{
                            dismiss()
                        }label:{
                            ZStack{
                                Text("Cancelar")
                                    .foregroundColor(.black)
                                
                            }
                        }
                        .padding(.horizontal, 40)
                        Spacer()
                    }
                    Button{
                        
                        let daysInt: [Int] = convertWeekToInt(daysOfTheWeek: selectedDays)
                        setAdresses()
                        self.userID = UserCRUD.getUserID()
                        let hourString = convertHourToString()
                        self.userName = UserCRUD.getUserName()

                        
                        
                        
                        let newGroup: RideGroup = RideGroup(type: selectedType.description, initialAdress: initalAdress, finalAdress: finalAdress, admin: userID, maxMembers: maxMembers, members: [userID], membersNames: [userName], hour: hourString, daysOfTheWeek: daysInt, userAdressLat: String(coordRua.latitude), userAdressLong: String(coordRua.longitude))!
                        
                        
                        groupOperations.addGroup(group: newGroup)
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
                    
                }
            }
            .navigationTitle("Criar Companhia")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
    
    
    func convertHourToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let hourString = dateFormatter.string(from: selectedDate)
        
        return hourString
    }
    
    
    func convertWeekToInt(daysOfTheWeek: [Bool]) -> [Int] {
        let intArray = daysOfTheWeek.map{ $0 ? 1 : 0 }
        return intArray
    }
    
    func setAdresses() {
        if !swapped {
            initalAdress = "Academy"
            finalAdress = nomeRua
        } else {
            initalAdress = nomeRua
            finalAdress = "Academy"
        }
    }
    
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}

