//
//  CloudKitItemProtocol.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 11/05/23.
//

import Foundation
import CloudKit

protocol CloudKitItemProtocol2 {
    init?(record: CKRecord)
    var record: CKRecord { get  }
}
