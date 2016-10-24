//
//  DataStructure.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-17.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import CoreData

struct AllVerbs {
    let base: String
    let past: String
    let participle: String
    let thirdPerson: String
    let ingForm: String
    init(allVerbs: NSArray, n: Int){
        base = allVerbs[n][0] as! String
        past = allVerbs[n][1] as! String
        participle = allVerbs[n][2] as! String
        thirdPerson = allVerbs[n][3] as! String
        ingForm = allVerbs[n][4] as! String
    }
}
struct Present {
    let allVerbs: AllVerbs
    var hint: String {return "I 'walk' to school every day"}
    var first: String{return  allVerbs.base}
    var second: String{return allVerbs.base}
    var third: String{return  allVerbs.thirdPerson}
    var fourth: String{return allVerbs.base}
    var fifth: String{return  allVerbs.base}
    var sixth: String{return  allVerbs.base}
}
struct Preterite {
    var hint: String {return "I 'walked' in the park yesterday"}
    let allVerbs: AllVerbs
    var first: String{return allVerbs.past}
    var second: String{return allVerbs.past}
    var third: String{return allVerbs.past}
    var fourth: String{return allVerbs.past}
    var fifth: String{return allVerbs.past}
    var sixth: String{return allVerbs.past}
    }
struct PresentPerfect {
    let allVerbs: AllVerbs
    var hint: String {return "You have 'walked' often to work"}
    var first: String{return "have \(allVerbs.participle)"}
    var second: String{return "have \(allVerbs.participle)"}
    var third: String{return "has \(allVerbs.participle)"}
    var fourth: String{return "have \(allVerbs.participle)"}
    var fifth: String{return "have \(allVerbs.participle)"}
    var sixth: String{return "have \(allVerbs.participle)"}
}
struct PastPerfect{
    let allVerbs: AllVerbs
    var hint: String {return "I had never 'walked' so much before I met you"}
    var first: String{return "had \(allVerbs.participle)"}
    var second: String{return "had \(allVerbs.participle)"}
    var third: String{return "had \(allVerbs.participle)"}
    var fourth: String{return "had \(allVerbs.participle)"}
    var fifth: String{return "had \(allVerbs.participle)"}
    var sixth: String{return "had \(allVerbs.participle)"}
    
}

struct PresentContinuous {
    let allVerbs: AllVerbs
    var hint: String {return "Now I 'am walking' to get there"}
    var first: String{return "am \(allVerbs.ingForm)"}
    var second: String{return "are \(allVerbs.ingForm)"}
    var third: String{return "is \(allVerbs.ingForm)"}
    var fourth: String{return "are \(allVerbs.ingForm)"}
    var fifth: String{return "are \(allVerbs.ingForm)"}
    var sixth: String{return "are \(allVerbs.ingForm)"}
}

struct PastContinuous{
    let allVerbs: AllVerbs
    var hint: String {return "I 'was walking' when I met her"}
    var first: String{return "was \(allVerbs.ingForm)"}
    var second: String{return "were \(allVerbs.ingForm)"}
    var third: String{return "was \(allVerbs.ingForm)"}
    var fourth: String{return "were \(allVerbs.ingForm)"}
    var fifth: String{return "were \(allVerbs.ingForm)"}
    var sixth: String{return "were \(allVerbs.ingForm)"}
}
struct PastPerfectContinuous {
    let allVerbs: AllVerbs
    var hint: String {return "They 'had been walking' for over an hour when the bus arrived "}
    var first: String{return "had been \(allVerbs.ingForm)"}
    var second: String{return "had been \(allVerbs.ingForm)"}
    var third: String{return "had been \(allVerbs.ingForm)"}
    var fourth: String{return "had been \(allVerbs.ingForm)"}
    var fifth: String{return "had been \(allVerbs.ingForm)"}
    var sixth: String{return "had been \(allVerbs.ingForm)"}
}
struct FuturContinuous{
    let allVerbs: AllVerbs
    var hint: String {return "I 'will be walking' until I reach you"}
    var first: String{return "will be \(allVerbs.ingForm)"}
    var second: String{return "will be \(allVerbs.ingForm)"}
    var third: String{return "will be \(allVerbs.ingForm)"}
    var fourth: String{return "will be \(allVerbs.ingForm)"}
    var fifth: String{return "will be \(allVerbs.ingForm)"}
    var sixth: String{return "will be \(allVerbs.ingForm)"}
}
struct PresentPerfectContinuous{
    let allVerbs: AllVerbs
    var hint: String {return "I 'have been walking' for the past hour"}
    var first: String{return "have been \(allVerbs.ingForm)"}
    var second: String{return "have been \(allVerbs.ingForm)"}
    var third: String{return "has been \(allVerbs.ingForm)"}
    var fourth: String{return "have been \(allVerbs.ingForm)"}
    var fifth: String{return "have been \(allVerbs.ingForm)"}
    var sixth: String{return "have been \(allVerbs.ingForm)"}
    
}
struct FuturPerfectContinuous{
    let allVerbs: AllVerbs
    var hint: String {return "I 'will have been walking' for two hours when I will finally arrive"}
    var first: String{return "will have been \(allVerbs.ingForm)"}
    var second: String{return "will have been \(allVerbs.ingForm)"}
    var third: String{return "will have been \(allVerbs.ingForm)"}
    var fourth: String{return "will have been \(allVerbs.ingForm)"}
    var fifth: String{return "will have been \(allVerbs.ingForm)"}
    var sixth: String{return "will have been \(allVerbs.ingForm)"}
    
}
struct Futur{
    let allVerbs: AllVerbs
    var hint: String {return "I 'will walk' to tomorrow to do my weekly exercise"}
    var first: String{return "will \(allVerbs.base)"}
    var second: String{return "will \(allVerbs.base)"}
    var third: String{return "will \(allVerbs.base)"}
    var fourth: String{return "will \(allVerbs.base)"}
    var fifth: String{return "will \(allVerbs.base)"}
    var sixth: String{return "will \(allVerbs.base)"}
}
struct FuturPerfect{
    let allVerbs: AllVerbs
    var hint: String {return "I 'will have walked' twenty kilometers before you arrive"}
    var first: String{return "will have \(allVerbs.past)"}
    var second: String{return "will have \(allVerbs.past)"}
    var third: String{return "will have \(allVerbs.past)"}
    var fourth: String{return "will have \(allVerbs.past)"}
    var fifth: String{return "will have \(allVerbs.past)"}
    var sixth: String{return "will have \(allVerbs.past)"}
}
struct Infinitive{
    let allVerbs: AllVerbs
    var first: String {return "to \(allVerbs.base)"}
}
struct Imperative{
    let allVerbs: AllVerbs
    var hint: String {return "'Walk' until you arrive"}
    var second: String{return allVerbs.base}
    var fourth: String{return "let's \(allVerbs.base)"}
    var fifth: String{return allVerbs.base}
}

public class DataController: NSObject {
    
    static let sharedInstance = DataController()
    
    private override init() {}
    
    private lazy var applicationDocumentDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex.predecessor()]
    }()
    
    private lazy var managerObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("TodoList", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managerObjectModel)
        let url = self.applicationDocumentDirectory.URLByAppendingPathComponent("TodoList.sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [NSLocalizedDescriptionKey: "Failed to initialized the application's saved data", NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the application's saved data", NSUnderlyingErrorKey: error as NSError]
            let wrappedError = NSError(domain: "Normand", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    public func saveContext() {
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}









