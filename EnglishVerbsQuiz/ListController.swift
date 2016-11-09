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

    @IBOutlet weak var delete: UIBarButtonItem!
    
    @IBOutlet weak var headerText: UILabel!
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verb", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let controller = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Improvement List"
        self.tabBarController?.tabBar.isHidden = false
        let myString: NSString = "List of wrong Quiz answers. \n Click to see conjugation or Swipe to Delete"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as
            String, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 18.0)!])
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18)!])
        myMutableString.addAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!], range: NSRange(location: 29, length: 44 ))
        headerText.attributedText = myMutableString
        
        self.tabBarController?.tabBar.isHidden = true
        fetch()
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)


        return configureCell(cell, atIndexPath: indexPath)
    }
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let item = fetchedResultsController.object(at: indexPath) as! Item
        cell.textLabel?.text = item.verb!
        cell.detailTextLabel?.text = item.tence!
        return cell
    }
    // MARK: NSFetchResultsControllerDelegate
    

    // MARK: Table view Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        managedObjectContext.delete(item)
        DataController.sharedInstance.saveContext()
        
 
        
     }

    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }


  
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var indexVerb: Int = 0
        if let indexPath = self.tableView.indexPathForSelectedRow {
            var verbe = verbList[(indexPath as NSIndexPath).row]
            let temps = verbTemp[(indexPath as NSIndexPath).row]
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
                let controller = segue.destination as! VerbeFinalViewController
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
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        verbList = []
        verbTemp = []
        fetch()
        tableView.reloadData()
    }

    @IBAction func deleteAll(_ sender: Any) {
        do {
            let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            
            // Save Changes
            try managedObjectContext.save()
            
        } catch {
            // Error Handling
            // ...
        }

        
    }
    
}
