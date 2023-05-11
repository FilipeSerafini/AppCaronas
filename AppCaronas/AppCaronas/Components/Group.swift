//
//  Group.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 11/05/23.
//

import Foundation
import CloudKit

struct Group: CloudKitItemProtocol2 {
    var record: CKRecord
    var name: String
    var days: String
    var hour: Int
    
    init(name: String, days: String, hour: Int) {
        self.name = name
        self.days = days
        self.hour = hour
        
        self.record = CKRecord(recordType: "Group")
    }
    
    init?(record: CKRecord) {
        guard let name = record["name"] as? String else { return nil }
        guard let days = record["days"] as? String else { return nil }
        guard let hour = record["hour"] as? Int else { return nil }
        
        self.name = name
        self.days = days
        self.hour = hour
        self.record = record
    }
    
}
