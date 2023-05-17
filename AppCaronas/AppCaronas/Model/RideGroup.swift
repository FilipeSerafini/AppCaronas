//
//  Group.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 09/05/23.
//

import Foundation
import SwiftUI
import CloudKit

enum RideType{
    case car
    case motorcycle
    case bus
    case uber
    case walk
    case bicycle
    
    init(value: String) {
        switch value {
        case "Carro":
            self = .car
        case "Moto":
            self = .motorcycle
        case "Uber":
            self = .uber
        case "Ônibus":
            self = .bus
        case "Bicicleta":
            self = .bicycle
        case "Caminhada":
            self = .walk
        default:
              self = .car
        }
    }
    
    var id: Self {self}
    
    var typeImage: Image{
        switch self{
        case .car:
            return Image(systemName: "car")
        case .motorcycle:
            return Image(systemName: "cart")
        case .bus:
            return Image(systemName: "bus")
        case .uber:
            return Image(systemName: "iphone.gen1")
        case .bicycle:
            return Image(systemName: "bicycle")
        case .walk:
            return Image(systemName: "figure.walk")
        }
    }
    
    var description: String{
        switch self{
        case .car:
            return "Carro"
        case .motorcycle:
            return "Moto"
        case .bus:
            return "Ônibus"
        case .uber:
            return "Uber"
        case .bicycle:
            return "Bicicleta"
        case .walk:
            return "Caminhada"
        }
    }
    
    var descriptionDetailed: String{
        switch self{
        case .car:
            return "Carona de Carro"
        case .motorcycle:
            return "Carona de Moto"
        case .bus:
            return "Companhia para Ônibus"
        case .uber:
            return "Companhia para Uber"
        case .bicycle:
            return "Companhia para Bicicleta"
        case .walk:
            return "Companhia para caminhada"
        }
    }
}

//MARK: VERIFICAR SE É NECESSARIO HASHABLE E SUAS FUNCOES E O ATRIBUTO ID JA QUE VAMOS PUXAR DO BANCO
//MARK: TROCAR NOME DA STRUCT

struct RideGroup: Hashable, CloudKitItemProtocol {
    
    var record: CKRecord

    //MARK: VERIFICAR SE PRECISA ID
    var id: String = UUID().uuidString
    var type: RideType
    var initialAdress: String
    var finalAdress: String
    var admin: String
    var maxMembers: Int
    var members: [String]
//    var isPriced: Int
    var hour: String
    var daysOfTheWeek: [Int]
    
    
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do grupo
    init?(
        type: String,
        initialAdress: String,
        finalAdress: String,
        admin: String,
        maxMembers: Int,
        members: [String],
//        isPriced: Int,
        hour: String,
        daysOfTheWeek: [Int]) {
            
            
            let record = CKRecord(recordType: "Group")
            
            record["rideType"] = type
            record["initialAdress"] = initialAdress
            record["finalAdress"] = finalAdress
            record["admin"] = admin
            record["maxMembers"] = maxMembers
            record["members"] = members
//            record["isPriced"] = isPriced
            record["hour"] = hour
            record["daysOfTheWeek"] = daysOfTheWeek
            
            
            
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
        guard let rideType = record["rideType"] as? String else { return nil }
        guard let initialAdress = record["initialAdress"] as? String else { return nil }
        guard let finalAdress = record["finalAdress"] as? String else { return nil }
        guard let admin = record["admin"] as? String else { return nil }
        guard let maxMembers = record["maxMembers"] as? Int else { return nil }
        guard let members = record["members"] as? [String] else { return nil }
//        guard let isPriced = record["isPriced"] as? Int else { return nil }
        guard let hour = record["hour"] as? String else { return nil }
        guard let daysOfTheWeek = record["daysOfTheWeek"] as? [Int] else { return nil }
        
        self.type = RideType(value: rideType)
        self.initialAdress = initialAdress
        self.finalAdress = finalAdress
        self.admin = admin
        self.maxMembers = maxMembers
        self.members = members
//        self.isPriced = isPriced
        self.hour = hour
        self.daysOfTheWeek = daysOfTheWeek
        
        self.record = record
        
    }
    
    
    static func == (lhs: RideGroup, rhs: RideGroup) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    
}

var groups = [g1, g2]


//MARK: VERIFICAR FORCED UNWRAP AQUI
var g1: RideGroup = RideGroup(type: "Carro", initialAdress: "Rua João Alfredo 277", finalAdress: "PUCRS", admin: "userID", maxMembers: 4, members: [p2.name, p3.name], hour: "15:00", daysOfTheWeek: [1, 0, 1, 0, 0, 0, 0])!
var g2: RideGroup = RideGroup(type: "Uber", initialAdress: "PUCRS", finalAdress: "Rua João Alfredo 277", admin: "userID2", maxMembers: 4, members: [p4.name, p5.name], hour: "15:00", daysOfTheWeek: [1, 0, 1, 0, 0, 0, 0])!
