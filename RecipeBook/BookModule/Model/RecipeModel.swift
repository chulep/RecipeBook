//
//  BookModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation
import CoreData
import UIKit

final class RecipeModel {
    
    func exportAllRecipe() -> [RecipeData] {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        do {
            print("Export CoreData DONE")
            return try context.fetch(fetchRequest)
        } catch {
            print("Export CoreData ERROR")
        }
        return []
    }
    
    func exportDetailRecipe(indexPath: IndexPath) -> RecipeData? {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        do {
            print("Export CoreData DONE")
            return try context.fetch(fetchRequest)[indexPath.row]
        } catch {
            print("Export CoreData ERROR")
        }
        return nil
    }
    
    
    func saveRecipe(name: String?, description: String?, image: UIImage?, exURL: String?) {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecipeData", in: context)
        let objectRecipe = NSManagedObject(entity: entity!, insertInto: context) as? RecipeData
        objectRecipe?.nameRecipe = name
        objectRecipe?.descriptionRecipe = description
        objectRecipe?.exURL = exURL
        guard let image = image else { return }
        objectRecipe?.imageRecipe = UIImage.jpegData(image)(compressionQuality: 0.5)
        do {
            try context.save()
            print("RECIPE SAVE")
        } catch {
            print("SAVE RECIPE ERROR")
        }
    }
    
    deinit {
        print("KILL RECIPE MODEL")
    }
    
}
