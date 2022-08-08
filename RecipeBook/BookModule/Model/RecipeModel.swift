//
//  BookModel.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 12.07.2022.
//

import Foundation
import CoreData
import UIKit

struct Recipe {
    let nameRecipe: String?
    let descriptionRecipe: String?
    let imageRecipe: Data?
    let exURL: String?
}

final class RecipeCoreData {
    
    private func mapping(data: [RecipeData]) -> [Recipe] {
        return data.map { Recipe(nameRecipe: $0.nameRecipe,
                                 descriptionRecipe: $0.descriptionRecipe,
                                 imageRecipe: $0.imageRecipe,
                                 exURL: $0.exURL)
        }
    }
    
    func exportAllRecipe() -> [Recipe] {
        var allRecipe = [RecipeData]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        do {
            print("Export CoreData DONE")
            allRecipe = try context.fetch(fetchRequest)
        } catch {
            print("Export CoreData ERROR")
        }
        return mapping(data: allRecipe)
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
    
}
