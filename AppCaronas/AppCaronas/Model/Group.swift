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

struct Week{
    var selected: [Bool] = [false, false, false, false, false, false, false]
    let letters: [String] = ["s","t","q","q","s","s","d"]
    
}

struct Group: Hashable, CloudKitItemProtocol{
    
    var record: CKRecord

    var id: String = UUID().uuidString
    var type: RideType
    var initialAdress: String
    var finalAdress: String
    var admin: String
    var maxMembers: Int
    var members: [String]
    var price: Bool
    var time: String
    var week: Week
    
    //init para transformar os atributos em records para o banco, e determinar o recordType do grupo
    init?(
        type: RideType,
        initialAdress: String,
        finalAdress: String,
        admin: String,
        maxMembers: Int,
        members: [String],
        price: Bool,
        time: String,
        week: Week) {
            
            let record = CKRecord(recordType: "Group")
            
            //MARK: DEFINIR COMO VAO SER PASSADOS OS TIPOS NAO NATURAIS, E VERIFICAR O PRICE(?)
//            record["rideType"] = type
            record["initialAdress"] = initialAdress
            record["finalAdress"] = finalAdress
            record["admin"] = admin
            record["maxMembers"] = maxMembers
            record["members"] = members
            record["price"] = price //deveria chegar um valor aqui, nao? (nao esquecer de alterar no outro init tambem
            record["time"] = time
//            record["week"] = week
            
            
            
        self.init(record: record)
    }
    
    //init para criar o objeto e atribuir o record a ele
    init?(record: CKRecord) {
        
//        guard let rideType = record["rideType"] as? String else { return nil }
        guard let initialAdress = record["initialAdress"] as? String else { return nil }
        guard let finalAdress = record["finalAdress"] as? String else { return nil }
        guard let admin = record["admin"] as? String else { return nil }
        guard let maxMembers = record["maxMembers"] as? Int else { return nil }
        guard let members = record["members"] as? [String] else { return nil }
        guard let price = record["price"] as? Bool else { return nil }
        guard let time = record["time"] as? String else { return nil }
        //        guard let week = record["week"] as? String else { return nil }
        
        
//        self.type =
        self.initialAdress = initialAdress
        self.finalAdress = finalAdress
        self.admin = admin
        self.maxMembers = maxMembers
        self.members = members
        self.price = price
        self.time = time
//        self.week =
        
        self.record = record
        
    }
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}

var groups = [g1, g2]

var weekTeste = Week(selected: [true, false, true, false, false, false, false])

//MARK: VERIFICAR FORCED UNWRAP AQUI
var g1: Group = Group(type: .car, initialAdress: "Rua João Alfredo 277", finalAdress: "PUCRS", admin: "userID", maxMembers: 4, members: [p2.name, p3.name], price: true, time: "12:30", week: weekTeste)!
var g2: Group = Group(type: .car, initialAdress: "PUCRS", finalAdress: "Rua João Alfredo 277", admin: "userID2", maxMembers: 4, members: [p4.name, p5.name], price: false, time: "17:30", week: weekTeste)!
