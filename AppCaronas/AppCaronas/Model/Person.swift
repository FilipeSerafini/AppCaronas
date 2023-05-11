//
//  People.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 08/05/23.
//

import Foundation

struct Person: Hashable{
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id: String = UUID().uuidString
    var name: String
    var number: String
    var groups: [Group]
    var photo: String?
    
}

var p1 = Person(name: "João", number: "111111111", groups: [])
var p2 = Person(name: "Maria", number: "222222222", groups: [])
var p3 = Person(name: "Qleber", number: "333333333", groups: [])
var p4 = Person(name: "Jorge", number: "444444444", groups: [])
var p5 = Person(name: "Pedro", number: "555555555", groups: [])


