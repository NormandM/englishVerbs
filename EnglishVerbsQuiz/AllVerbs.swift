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
    init(allVerbs: [[String]], n: Int){
        base = allVerbs[n][0]
        past = allVerbs[n][1]
        participle = allVerbs[n][2]
        thirdPerson = allVerbs[n][3]
        ingForm = allVerbs[n][4]
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
    var first: String{return "will have \(allVerbs.participle)"}
    var second: String{return "will have \(allVerbs.participle)"}
    var third: String{return "will have \(allVerbs.participle)"}
    var fourth: String{return "will have \(allVerbs.participle)"}
    var fifth: String{return "will have \(allVerbs.participle)"}
    var sixth: String{return "will have \(allVerbs.participle)"}
}
struct Infinitive{
    let allVerbs: AllVerbs
    var first: String {return "to \(allVerbs.base)"}
}
struct Imperative{
    let allVerbs: AllVerbs
    var hint: String {return "'Walk' until you arrive"}
    var second: String{return allVerbs.base}
    var fourth: String{return "let’s \(allVerbs.base)"}
    var fifth: String{return allVerbs.base}
}
struct ConditionalSimple{
    let allVerbs: AllVerbs
    var hint : String {return "I 'would walk' it if I had to go"}
    var first: String {return "would \(allVerbs.base)"}
    var second:String {return "would \(allVerbs.base)"}
    var third: String {return "would \(allVerbs.base)"}
    var fourth: String {return "would \(allVerbs.base)"}
    var fifth: String {return "would \(allVerbs.base)"}
    var sixth: String {return "would \(allVerbs.base)"}
}
struct ConditionalProgressive{
    let allVerbs: AllVerbs
    var hint : String {return "I 'would be walking' if it was not so far"}
    var first: String {return "would be \(allVerbs.ingForm)"}
    var second:String {return "would be \(allVerbs.ingForm)"}
    var third: String {return "would be \(allVerbs.ingForm)"}
    var fourth: String {return "would be \(allVerbs.ingForm)"}
    var fifth: String {return "would be \(allVerbs.ingForm)"}
    var sixth: String {return "would be \(allVerbs.ingForm)"}
}
struct ConditionalPerfect{
    let allVerbs: AllVerbs
    var hint : String {return "I 'would have walke' but he gave me a lift"}
    var first: String {return "would have \(allVerbs.participle)"}
    var second:String {return "would have \(allVerbs.participle)"}
    var third: String {return "would have \(allVerbs.participle)"}
    var fourth: String {return "would have \(allVerbs.participle)"}
    var fifth: String {return "would have \(allVerbs.participle)"}
    var sixth: String {return "would have \(allVerbs.participle)"}
}
struct ConditionalPerfectProgressive{
    let allVerbs: AllVerbs
    var hint : String {return "I 'would have been walking' but the road had been closed"}
    var first: String {return "would have been \(allVerbs.ingForm)"}
    var second:String {return "would have been \(allVerbs.ingForm)"}
    var third: String {return "would have been \(allVerbs.ingForm)"}
    var fourth: String {return "would have been \(allVerbs.ingForm)"}
    var fifth: String {return "would have been \(allVerbs.ingForm)"}
    var sixth: String {return "would have been \(allVerbs.ingForm)"}
}


open class DataController: NSObject {
    
    static let sharedInstance = DataController()
    
    fileprivate override init() {}
    
    fileprivate lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[(urls.endIndex - 1)]
    }()
    
    fileprivate lazy var managerObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "VerbStat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managerObjectModel)
        let url = self.applicationDocumentDirectory.appendingPathComponent("VerbStat.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [NSLocalizedDescriptionKey: "Failed to initialized the application's saved data" as AnyObject, NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the application's saved data" as AnyObject, NSUnderlyingErrorKey: error as NSError]
            let wrappedError = NSError(domain: "Normand", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    open func saveContext() {
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}









