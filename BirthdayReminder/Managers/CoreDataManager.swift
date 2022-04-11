import Foundation
import UIKit
import CoreData

final class CoreDataManager{
    static let instance = CoreDataManager()
    
    func saveBirthday(_ date: Birthday) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BirthdayEntity", in: managedContext)!
        
        let dateInfo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        dateInfo.setValue(date.name, forKey: "name")
        dateInfo.setValue(date.surname, forKey: "surname")
        dateInfo.setValue(date.birthDate, forKey: "date")
        
        
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    func getBirthday() -> [Birthday]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BirthdayEntity")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var birthdays = [Birthday]()
            for object in objects {
                guard let name = object.value(forKey: "name") as? String,
                      let surname = object.value(forKey: "surname") as? String,
                      let birthDate = object.value(forKey: "date")
                else { return nil }
                let date = Birthday(name: name, surname: surname, birthDate: birthDate as! Date)
                birthdays.insert(date, at: 0)
            }
            return birthdays
        } catch let error as NSError {
                print("Error - \(error)")
        }
        return nil
    }
    
    func deleteEntity(usersArray: [Birthday], indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BirthdayEntity")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            managedContext.delete(objects.reversed()[indexPath.row])
        } catch let error as NSError {
            print(error)
        }
        do {
            try managedContext.save()
            guard let fetchArray = CoreDataManager.instance.getBirthday() else {return}
            _ = fetchArray.reversed()
        } catch let error as NSError {
            print(error)
        }
    }
    
    private init() {}
}
