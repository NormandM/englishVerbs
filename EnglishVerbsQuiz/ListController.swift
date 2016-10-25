//
//  ListController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-18.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

class ListController: UITableViewController, NSFetchedResultsControllerDelegate {
    var verbTot: [[String]] = []
    var verbList: [String] = []
    var verbTemp: [String] = []
    var noVerb: [Int] = []
    var verbArray: NSArray = []

    @IBOutlet weak var headerText: UILabel!
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchRequest: NSFetchRequest = {
        let request  = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verb", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let controller = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Improvement List"
        
        
        let myString: NSString = "List of wrong Quiz answers. \n Click to see conjugation or Swipe to Delete"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as
            String, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 18.0)!])
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName: UIFont(name: "Georgia", size: 18)!])
        myMutableString.addAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!], range: NSRange(location: 29, length: 44 ))
        headerText.attributedText = myMutableString
        fetch()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)


        return configureCell(cell, atIndexPath: indexPath)
    }
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
        cell.textLabel?.text = item.verb!
        cell.detailTextLabel?.text = item.tence!
        return cell
    }
    // MARK: NSFetchResultsControllerDelegate
    

    // MARK: Table view Delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
        
 
        
     }

    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }


  
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexVerb: Int = 0
        if let indexPath = self.tableView.indexPathForSelectedRow {
            var verbe = verbList[indexPath.row]
            let temps = verbTemp[indexPath.row]
            print(temps)
            verbe = String(verbe.characters.dropFirst(3))
            
            var n = 0
            let arrayTrans = verbArray as! [[String]]
            for verb in arrayTrans {
                if verbe == verb[0] {
                    indexVerb = n
                }
                n = n + 1
            }
            
            let personVerb = toChooseVerb().chooseVerb(temps: temps, indexChoice: indexVerb, verbArray: verbArray)
            if segue.identifier == "showCorrectVerb"{
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                let controller = segue.destinationViewController as! VerbeFinalViewController
                controller.personVerb = personVerb
                controller.verbeInfinitif = verbe
                controller.temps = temps
                
            }
            
        }
    }
    func fetch() {
        do {
            try self.fetchedResultsController.performFetch()
        }catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        let verbItem = fetchedResultsController.fetchedObjects as! [Item]
        var n = 0
        //Mark ! optional unwrapped
        for verb in verbItem {
            verbList.append(verb.verb!)
            verbTemp.append(verb.tence!)
            n = n + 1
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        verbList = []
        verbTemp = []
        fetch()
        tableView.reloadData()
        print(verbList)
    }

   
}
