//
//  CreateGroupView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 16/05/23.
//

import SwiftUI



struct CreateGroupView: View {
    
    let groupOperations: RideGroupCRUD = RideGroupCRUD()
    
    
    @State var selectedDate = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!
    
    @State var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    @State var selectedType: RideType = .car
    @State private var maxMembers = 2
    @State var initalAdress: String = ""
    @State var finalAdress: String = ""
    @State var userID: String = ""
    
    let letters: [String] = ["s","t","q","q","s","s","d"]
    
    @Namespace private var animation
    @State var swapped = false
    
    @StateObject var locationViewModelReserva = LocationSearchViewModel()

    @State var nomeRua = " "

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
                                NavigationLink{
                                    HomeView(selecao: false, nomeRua: $nomeRua).environmentObject(locationViewModelReserva)
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
                                    HomeView(selecao: false, nomeRua: $nomeRua).environmentObject(locationViewModelReserva)
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
                            selectedDays[i].toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: CGFloat(30 + 4))
                                    .foregroundColor(selectedDays[i] ? .green : Color(.lightGray))
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
                    
                    Picker("Número máximo de participantes", selection: $maxMembers) {
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
                    
                    let daysInt: [Int] = convertWeekToInt(daysOfTheWeek: selectedDays)
                    setAdresses()
                    self.userID = UserCRUD.getUserID()
                    let hourString = convertHourToString()
                    
                    
                    
                    let newGroup: RideGroup = RideGroup(type: selectedType.description, initialAdress: initalAdress, finalAdress: finalAdress, admin: userID, maxMembers: maxMembers, members: [], hour: hourString, daysOfTheWeek: daysInt)!
                    
                    
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
                //                .listStyle(.inset)
                
                
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
