//
//  CoreDataExtensions.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//
import CoreData
import UIKit

extension NSManagedObject {
    static var className: String {
        return String(describing: self)
    }
}

extension CoreDataModel where Self: NSManagedObject {
    static var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

extension CoreDataModel where Self: NSManagedObject {
    static func all() -> [Self] {
        let fetchRequest = NSFetchRequest<Self>(entityName: Self.className)
        fetchRequest.predicate = NSPredicate(value: true)
        
        guard let data = try? context.fetch(fetchRequest) else {
            return []
        }
        return data
    }
    
    static func find(predicate: NSPredicate) -> [Self] {
        let fetchRequest = NSFetchRequest<Self>(entityName: Self.className)
        fetchRequest.predicate = predicate
        
        guard let data = try? context.fetch(fetchRequest) else {
            return []
        }
        return data
    }

}

extension CoreDataModel where Self: NSManagedObject {
    func save() -> Bool {
        guard let _ = try? Self.context.save() else { return false }
        return true
    }
}

extension CoreDataModel where Self: NSManagedObject {
    func destroy() -> Bool {
        Self.context.delete(self)
        guard let _ = try? Self.context.save() else { return false }
        return true
    }
}
