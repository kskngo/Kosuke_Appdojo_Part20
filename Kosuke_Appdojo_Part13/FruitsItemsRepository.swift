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

    private static let fruitsItemsKey = "fruitsItemsKey"
    var container: NSPersistentContainer!

//    @discardableResult
//    func save2(fruitsItems: [FruitsItem]) -> Bool {
//        do {
//            let saveData = try JSONEncoder().encode(fruitsItems)
//            UserDefaults.standard.set(saveData, forKey: Self.fruitsItemsKey)
//            return true
//        } catch {
//            return false
//        }
//    }

    @discardableResult
    func save(fruitsItems: [FruitsItem]) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Fruits", in: managedContext)!

        let fruits = NSManagedObject(entity: entity, insertInto: managedContext)
        fruits.setValue(fruitsItems[0].name, forKey: "name")
        fruits.setValue(fruitsItems[0].isChecked, forKey: "isChecked")

        appDelegate.saveContext()
        return true
    }

    func load() -> [FruitsItem]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Fruits>(entityName: "Fruits")

        do {
            let results = try managedContext.fetch(fetchRequest)
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

//    func load2() -> [FruitsItem]? {
//        do {
//            guard let data = UserDefaults.standard.data(forKey: Self.fruitsItemsKey) else {
//                return nil
//            }
//            return try JSONDecoder().decode([FruitsItem].self, from: data)
//        } catch {
//            return nil
//        }
//    }
}
