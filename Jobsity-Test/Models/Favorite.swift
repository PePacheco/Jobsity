//
//  Favorite.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject, Identifiable, CoreDataModel {
    
    convenience init(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: Self.className, in: Self.context)
        self.init(entity: entity!, insertInto: Self.context)
        self.name = name
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String
}
