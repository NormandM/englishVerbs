//
//  Item+CoreDataProperties.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-18.
//  Copyright © 2016 Normand Martin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var verb: String?
    @NSManaged var tence: String?
    @NSManaged var noBad: Int32


}
