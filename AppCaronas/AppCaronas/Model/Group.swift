//
//  Group.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 09/05/23.
//

import Foundation
import SwiftUI


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

struct Group: Hashable{
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String = UUID().uuidString
    var type: RideType
    var initialAdress: String
    var finalAdress: String
    var leader: Person
    var maxMembers: Int
    var members: [String]
    var price: Bool
    var time: String
    var week: Week
//    var monday: Bool = false
//    var tuesday: Bool = false
//    var wednesday: Bool = false
//    var thursday: Bool = false
//    var friday: Bool = false
//    var saturday: Bool = false
//    var sunday: Bool = false
    
}

var groups = [g1, g2]

var weekTeste = Week(selected: [true, false, true, false, false, false, false])

var g1: Group = Group(type: .car, initialAdress: "Rua João Alfredo 277", finalAdress: "PUCRS", leader: p1, maxMembers: 4, members: [p2.name, p3.name], price: true, time: "12:30", week: weekTeste)
var g2: Group = Group(type: .car, initialAdress: "PUCRS", finalAdress: "Rua João Alfredo 277", leader: p1, maxMembers: 4, members: [p4.name, p5.name], price: false, time: "17:30", week: weekTeste)
