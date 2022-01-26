//
//  Protocols.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//

import Foundation
import CoreData

protocol Readable {
    static func all() -> [Self]
    static func find(predicate: NSPredicate) -> [Self]
}

protocol Writeable {
    func save() -> Bool
}

protocol Deletable {
    func destroy() -> Bool
}

protocol CoreDataModel: Writeable, Deletable, Readable {
    static var context: NSManagedObjectContext { get }
}
