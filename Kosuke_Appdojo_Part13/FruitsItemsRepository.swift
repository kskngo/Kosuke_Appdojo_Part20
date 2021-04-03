//
//  FruitsItemsRepository.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/04/03.
//

import Foundation

struct FruitsItemsRepository {

    private static let fruitsItemsKey = "fruitsItemsKey"

    @discardableResult
    func save(fruitsItems: [FruitsItem]) -> Bool {
        do {
            let saveData = try JSONEncoder().encode(fruitsItems)
            UserDefaults.standard.set(saveData, forKey: Self.fruitsItemsKey)
            return true
        } catch {
            return false
        }
    }

    func load() -> [FruitsItem]? {
        do {
            guard let data = UserDefaults.standard.data(forKey: Self.fruitsItemsKey) else {
                return nil
            }
            return try JSONDecoder().decode([FruitsItem].self, from: data)
        } catch {
            return nil
        }
    }
}
