//
//  ResponseEvaluation.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-09.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
import CoreData
struct ResponseEvaluation {
    static func evaluate(tempsVerb: String,  infinitif: String, userResponse: String, rightAnswer: String, rightAnswer2: String, difficultyLevel: DifficultyLevel) -> QuizResult{
        let dataController = DataController.sharedInstance
        let managedObjectContext = DataController.sharedInstance.managedObjectContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier )
            let predicateTemps = NSPredicate(format: "tence = %@",  tempsVerb )
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateTemps])
            request.predicate = andPredicate
            return request
        }()
        var quizResultString = String()
        var itemVerbe: Item!
        var itemVerbArray: [Item]?
        do {
            itemVerbArray = try managedObjectContext.fetch(fetchRequest) as? [Item]
        }catch  let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        if itemVerbArray == [] {
            itemVerbe = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataController.managedObjectContext) as? Item
            itemVerbe.setValue(tempsVerb, forKey: "tence")
            itemVerbArray?.append(itemVerbe)
        }else{
            itemVerbe = itemVerbArray![0]
        }

        if   itemVerbe.tence?.caseInsensitiveCompare(tempsVerb) == .orderedSame && (userResponse.caseInsensitiveCompare(rightAnswer)  == .orderedSame || (userResponse.caseInsensitiveCompare(rightAnswer2) == .orderedSame && rightAnswer2 != "")){
            if difficultyLevel == .FACILE {
                itemVerbe.noBad = itemVerbe.noBad + 1
                let itemVerbeUpdate = itemVerbe as NSManagedObject
                itemVerbeUpdate.setValue(itemVerbe.noBad, forKey: "noBad")
                let thisQuizHintAnswer = UserDefaults.standard.integer(forKey: "thisQuizHintAnswer")
                UserDefaults.standard.set(thisQuizHintAnswer + 1, forKey: "thisQuizHintAnswer")
                quizResultString = QuizResult.help.rawValue
            }else{
                itemVerbe.numberGoodAnswers = itemVerbe.numberGoodAnswers + 1
                let itemVerbeUpdate = itemVerbe as NSManagedObject
                itemVerbeUpdate.setValue(itemVerbe.numberGoodAnswers, forKey: "numberGoodAnswers")
                let thisQuizGoodAnswer = UserDefaults.standard.integer(forKey: "thisQuizGoodAnswer")
                UserDefaults.standard.set(thisQuizGoodAnswer + 1, forKey: "thisQuizGoodAnswer")
                quizResultString = QuizResult.good.rawValue
            }
        }else{
            itemVerbe.numberBadAnswers = itemVerbe.numberBadAnswers + 1
            let itemVerbeUpdate = itemVerbe as NSManagedObject
            itemVerbeUpdate.setValue(itemVerbe.numberBadAnswers, forKey: "numberBadAnswers")
            let thisQuizBadAnswer = UserDefaults.standard.integer(forKey: "thisQuizBadAnswer")
            UserDefaults.standard.set(thisQuizBadAnswer + 1, forKey: "thisQuizBadAnswer")
            quizResultString = QuizResult.bad.rawValue
        }
        dataController.saveContext()
        return QuizResult(rawValue: quizResultString)!
    }
    
}
enum QuizResult: String {
    case good
    case bad
    case help
}
