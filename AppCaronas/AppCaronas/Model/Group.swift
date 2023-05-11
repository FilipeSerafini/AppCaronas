//
//  Group.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 09/05/23.
//

import Foundation
import SwiftUI


enum rideType{
    case car
    case motorcycle
    case bus
    case uber
    case walk
    case bicycle
    
    var description: Image{
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
}

struct Group: Hashable{
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String = UUID().uuidString
    var type: rideType
    var initialAdress: String
    var finalAdress: String
    var leader: Person
    var maxMembers: Int
    var members: [Person]
    var time: String
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    
}

var groups = [g1, g2]

var g1: Group = Group(type: .car, initialAdress: "Rua João Alfredo 277", finalAdress: "PUCRS", leader: p1, maxMembers: 4, members: [p2, p3], time: "12:30", monday: true, wednesday: true)
var g2: Group = Group(type: .car, initialAdress: "PUCRS", finalAdress: "Rua João Alfredo 277", leader: p1, maxMembers: 4, members: [p4, p5], time: "17:30", tuesday: true, friday: true)
