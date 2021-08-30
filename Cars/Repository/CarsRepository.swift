//
//  CarsListService.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation
import UIKit
import CoreData

class CarsRepository {
    private let stack = CoreDataStack.shared

    func saveToDB(_ cars: [Cars]) {
        let context = stack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.carItem, in: context)!
        self.clear()
        for car in cars {
            let carItem = NSManagedObject(entity: entity, insertInto: context)
            carItem.setValue(car.id, forKeyPath: Constants.Entity.Keypath.id)
            carItem.setValue(car.title, forKeyPath: Constants.Entity.Keypath.title)
            carItem.setValue(car.details, forKeyPath: Constants.Entity.Keypath.details)
            carItem.setValue(car.dateTime, forKeyPath: Constants.Entity.Keypath.dateTime)
            carItem.setValue(car.url, forKeyPath: Constants.Entity.Keypath.url)
            stack.saveContext()
        }
    }
    
    func fetch() -> [CarsCellViewModel]? {
        let context = stack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarItem")
        do {
            let carsList = try context.fetch(fetchRequest)
            return carsList.map { CarsCellViewModel(id: $0.value(forKey: "id") as? Int, title: $0.value(forKey: "title") as? String, dateTime: $0.value(forKey: "dateTime") as? String, description: $0.value(forKey: "details") as? String, url: $0.value(forKey: "url") as? String)}
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    private func clear() {
        let context = stack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarItem")
        do {
            let _ = try context.fetch(fetchRequest).map { context.delete($0)}
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
