//
//  CoreDataInteraction.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 11.08.2022.
//

import CoreData

enum ExportRequest {
    case allRecipe
    case favoriteRecipe
}

enum ForModule {
    case bookModule
    case favoriteModule
}

protocol CoreDataInteractionType {
    func exportRecipe(request: ExportRequest) -> [Recipe]
    func saveRecipe(name: String?, description: String?, image: Data?, exURL: String?)
    func tapToFavorite(forModule: ForModule, indexPath: IndexPath, favorite: Bool)
    func deleteRecipe(indexPath: IndexPath)
    
}

final class CoreDataInteraction: CoreDataInteractionType {
    
    func exportRecipe(request: ExportRequest) -> [Recipe] {
        var allRecipe = [RecipeData]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        if request == .favoriteRecipe {
            let predicate = NSPredicate(format: "favoriteRecipe == %@", NSNumber(value: true))
            fetchRequest.predicate = predicate
        }
        
        do {
            print("Export CoreData DONE")
            allRecipe = try context.fetch(fetchRequest)
        } catch {
            print("Export CoreData ERROR")
        }
        return mapping(data: allRecipe)
    }
    
    func saveRecipe(name: String?, description: String?, image: Data?, exURL: String?) {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecipeData", in: context)
        let objectRecipe = NSManagedObject(entity: entity!, insertInto: context) as? RecipeData
        objectRecipe?.nameRecipe = name
        objectRecipe?.descriptionRecipe = description
        objectRecipe?.exURL = exURL
        objectRecipe?.favoriteRecipe = false
        objectRecipe?.imageRecipe = image
        do {
            try context.save()
            print("RECIPE SAVE")
        } catch {
            print("SAVE RECIPE ERROR")
        }
    }
    
    func tapToFavorite(forModule: ForModule, indexPath: IndexPath, favorite: Bool) {
        var allRecipe = [RecipeData]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        if forModule == .favoriteModule {
            let predicate = NSPredicate(format: "favoriteRecipe == %@", NSNumber(value: true))
            fetchRequest.predicate = predicate
        }
        
        do {
            print("Export CoreData DONE")
            allRecipe = try context.fetch(fetchRequest)
        } catch {
            print("Export CoreData ERROR")
        }
        
        let object = allRecipe[indexPath.row] as NSManagedObject
        object.setValue(favorite, forKey: "favoriteRecipe")
        
        do {
            try context.save()
            print("SAVE FAVORITE")
        } catch {
            print("EDIT ERROR")
        }
    }
    
    func deleteRecipe(indexPath: IndexPath) {
        var allRecipe = [RecipeData]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        do {
            allRecipe = try context.fetch(fetchRequest)
            context.delete(allRecipe[indexPath.row])
            try context.save()
            print("DELETE DONE")
        } catch {
            print("DELETE CoreData ERROR")
        }
    }
    
    private func mapping(data: [RecipeData]) -> [Recipe] {
        return data.map { Recipe(nameRecipe: $0.nameRecipe,
                                 descriptionRecipe: $0.descriptionRecipe,
                                 imageRecipe: $0.imageRecipe,
                                 exURL: $0.exURL,
                                 favoriteRecipe: $0.favoriteRecipe) }
    }
    
}
