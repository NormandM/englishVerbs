//
//  StatisticController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 17-06-02.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

class StatisticController: UITableViewController, NSFetchedResultsControllerDelegate {
    var tenseArray: [String] = ["Present", "Preterite", "Present Perfect", "Past Perfect", "Present Continuous", "Past Continuous", "Past Perfect Continuous", "Futur Continuous", "Present Perfect Continuous", "Futur Perfect Continuous", "Futur", "Futur Perfect", "Imperative"]
    var tenseList: [String] = []
    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verb", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let controller = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self as NSFetchedResultsControllerDelegate
        return controller
    }()
    var items: [Item] = []
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
//        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
//        header.textLabel!.textColor = UIColor.white //make the text white
//        header.alpha = 1.0 //make the header transparent
//        
//    }

//        func delete() {
//            do {
//                let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
//                
//                for item in items {
//                    managedObjectContext.delete(item)
//                }
//                
//                // Save Changes
//                try managedObjectContext.save()
//                
//            } catch {
//                // Error Handling
//                // ...
//            }
//        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz statistics"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tenseArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let statPercent  = addResponses(tense: tenseArray[indexPath.row])
        cell.textLabel?.text = "\(tenseArray[indexPath.row]): \(statPercent)"

        return cell
    }
    func fetch() {
        do {
            try self.fetchedResultsController.performFetch()
        }catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
    }

    func addResponses(tense: String) -> String{
        fetch()
        let verbItem = fetchedResultsController.fetchedObjects as! [Item]
        var goodAnswers = 0.0
        var badAnswers = 0.0
        for verb in verbItem {
            if tense == verb.tence {
                badAnswers = Double(verb.numberBadAnswers) + badAnswers
                goodAnswers = Double(verb.numberGoodAnswers) + goodAnswers
            }
            
        }
        if (goodAnswers + badAnswers) != 0 {
            let stat = String (format: "%.0f" , (goodAnswers / (goodAnswers + badAnswers)) * 100)
            return "\(stat)%"
        }else {
            return "_"
        }
    }



}
