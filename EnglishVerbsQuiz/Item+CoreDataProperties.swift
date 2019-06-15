//
//  Item+CoreDataProperties.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 17-05-31.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var tence: String?
    @NSManaged public var verb: String?
    @NSManaged public var noBad: Int32
    @NSManaged public var numberGoodAnswers: Int32
    @NSManaged public var numberBadAnswers: Int32

}
