//
//  CloudKitItemProtocol.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 12/05/23.
//

import Foundation
import CloudKit

protocol CloudKitItemProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}
