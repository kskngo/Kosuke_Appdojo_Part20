//
//  FruitsItemsRepository.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/04/03.
//

import Foundation
import CoreData
import UIKit

struct FruitsItemsRepository {
    private static let fruitsEntityName = "Fruits"
    private static let nameKey = "name"
    private static let isCheckedKey = "isChecked"

//    var container: NSPersistentContainer!

    @discardableResult
    func save(fruitsItems: [FruitsItem]) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: Self.fruitsEntityName, in: managedContext) else {
            return false
        }

        for fruitsItem in fruitsItems {
            let fruits = NSManagedObject(entity: entity, insertInto: managedContext)
            fruits.setValue(fruitsItem.name, forKey: Self.nameKey)
            fruits.setValue(fruitsItem.isChecked, forKey: Self.isCheckedKey)
        }
        appDelegate.saveContext()
        return true
    }

    @discardableResult
    func add(fruitsItem: FruitsItem) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fruits = NSEntityDescription.insertNewObject(forEntityName: Self.fruitsEntityName, into: managedContext)

//        let fruits = NSManagedObject(entity: entity, insertInto: managedContext)
        fruits.setValue(fruitsItem.name, forKey: Self.nameKey)
        fruits.setValue(fruitsItem.isChecked, forKey: Self.isCheckedKey)

        appDelegate.saveContext()
        return true
    }

    func load() -> [FruitsItem]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Fruits>(entityName: Self.fruitsEntityName)

        do {
            let results = try managedContext.fetch(fetchRequest)
            print(results.count)
            var fruitsItems = [FruitsItem]()
            for result in results {
                if let name = result.name, let isChecked = result.isChecked as? Bool {
                    let fruitsItem = FruitsItem(name: name, isChecked: isChecked)
                    fruitsItems.append(fruitsItem)
                }
            }
            return fruitsItems
        } catch {
            return nil
        }
    }

    func update() -> Bool {
        return true
    }
}
