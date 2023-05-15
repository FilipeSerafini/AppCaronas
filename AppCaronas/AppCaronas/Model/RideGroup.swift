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

struct RideGroup: Hashable, CloudKitItemProtocol {
    
    var record: CKRecord
    
    var id: String = UUID().uuidString
    var type: RideType
    var initialAdress: String
    var finalAdress: String
//    var leader: Person
    var maxMembers: String
    var members: [Person]
    var time: String
    
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    
    init?(initialAdress: String, finalAdress: String, maxMembers: String, time: String) {
        self.initialAdress = initialAdress
        self.finalAdress = finalAdress
        self.maxMembers = maxMembers
        self.time = time
        self.type = .car
        
        self.monday = false
        self.tuesday = false
        self.wednesday = false
        self.thursday = false
        self.friday = false
        self.saturday = false
        self.sunday = false
        
        self.members = []
        
        
        self.record = CKRecord(recordType: "Group")
        
//        self.init(record: record)
    }

    init?(record: CKRecord) {
//        guard let type
        guard let initialAdress = record["initialAdress"] as? String else { return nil }
        guard let finalAdress = record["finalAdress"] as? String else { return nil }
//        guard let leader = record["groupLeader"] as? Person else { return nil }
        guard let maxMembers = record["maxMembers"] as? String else { return nil }
//        guard let members = record["members"] as? [Person] else { return nil }
        guard let time = record["time"] as? String else { return nil }
        
        self.initialAdress = initialAdress
        self.finalAdress = finalAdress
        self.maxMembers = maxMembers
        self.time = time
        self.type = .car
        
        self.monday = false
        self.tuesday = false
        self.wednesday = false
        self.thursday = false
        self.friday = false
        self.saturday = false
        self.sunday = false
        
        self.members = []
        

        
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

var g1: RideGroup = RideGroup(initialAdress: "Rua Guaraja 51", finalAdress: "Academy", maxMembers: "5", time: "17:00")!
var g2: RideGroup = RideGroup(initialAdress: "Academy", finalAdress: "Ferreira Viana 209", maxMembers: "5", time: "17:00")!


//var g1: CompGroup = CompGroup(type: .car, initialAdress: "Rua João Alfredo 277", finalAdress: "PUCRS", leader: p1, maxMembers: "4", members: [p2, p3], time: "12:30", monday: true, wednesday: true)
//var g2: CompGroup = CompGroup(type: .car, initialAdress: "PUCRS", finalAdress: "Rua João Alfredo 277", leader: p1, maxMembers: "4", members: [p4, p5], time: "17:30", tuesday: true, friday: true)
