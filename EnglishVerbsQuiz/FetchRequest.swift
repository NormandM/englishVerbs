//
//  FetchRequest.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2019-02-17.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
import CoreData

struct FetchRequest{
    static func evaluate(tempsVerb: String)-> ((Int, Int, Int, String)){
        let managedObjectContext = DataController.sharedInstance.managedObjectContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier )
            let predicateTemps = NSPredicate(format: "tence = %@",  tempsVerb )
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateTemps])
            request.predicate = andPredicate
            return request
        }()
        var itemVerbArray: [Item]?
        var bonneReponse = Int()
        var bonnReponseTemp = Int()
        var mauvaiseReponse = Int()
        var result = String()
        do {
            itemVerbArray = try managedObjectContext.fetch(fetchRequest) as? [Item]
        }catch  let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
            if itemVerbArray == [] {
                bonneReponse = 0
                bonnReponseTemp = 0
                mauvaiseReponse = 0
            }else{
                let item = itemVerbArray![0]
                bonneReponse = Int(item.numberGoodAnswers)
                bonnReponseTemp = Int(item.noBad)
                mauvaiseReponse = Int(item.numberBadAnswers)
            }
            if (bonneReponse + mauvaiseReponse + bonnReponseTemp) != 0 {
                result = String(round(Double(bonneReponse + bonnReponseTemp) / Double(bonneReponse + mauvaiseReponse + bonnReponseTemp) * 100)) + "%"
            }else{
                result = "_"
            }
        return (bonneReponse, bonnReponseTemp, mauvaiseReponse, result)
    }

}

