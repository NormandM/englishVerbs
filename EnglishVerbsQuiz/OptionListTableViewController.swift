//
//  OptionListTableViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-26.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
class OptionListTableViewController: UITableViewController{
    var selectedTimeVerbes = NSMutableSet()
    var arraySelection: [String] = []
    var verbArray: NSArray = []
    var arraySectionCount: Int = 0
    var arrayCount: Int = 0
    

    let sectionArray: [String] = ["Choose a group of verb", "Choose a tense"]
    let tenseArray: [[String]] = [[ "All 1000 Verbs!", "100 most Common Verbs", "Irregular Verbs"], ["Present", "Preterite", "Present Perfect", "Past Perfect", "Present Continuous", "Past Continuous", "Past Perfect Continuous", "Futur Continuous", "Present Perfect Continuous", "Futur Perfect Continuous", "Futur", "FuturPerfect", "Imperative"]]
    // Changing backgroung colors of the header of sections
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1.0 //make the header transparent
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choose content of your Quiz"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Table view data source
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionArray[section]
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        arraySectionCount = sectionArray.count
        return arraySectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCount = tenseArray[section].count
        return arrayCount
    }
    // Next code is to enable checks for each cell selected
    func configure(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            var n = 0
            while n < 3 {
                let indexPath2 = NSIndexPath(forRow: n, inSection: 0)
                let cellInd = tableView.cellForRowAtIndexPath(indexPath2)
                cellInd?.accessoryType = .None
                n = n + 1
                    if let text = cellInd?.textLabel?.text, i = arraySelection.indexOf(text){
                        arraySelection.removeAtIndex(i)
                    }

            }
        }else if indexPath.section == 1 {
            var n = 0
            while n < 14 {
                let indexPath2 = NSIndexPath(forRow: n, inSection: 1)
                let cellInd = tableView.cellForRowAtIndexPath(indexPath2)
                cellInd?.accessoryType = .None
                n = n + 1
                if let text = cellInd?.textLabel?.text, i = arraySelection.indexOf(text){
                    arraySelection.removeAtIndex(i)
                }
            }

        }

        if selectedTimeVerbes.containsObject(indexPath) {
            // selected
            cell.accessoryType = .Checkmark
            arraySelection.append(self.tenseArray[indexPath.section][indexPath.row])
        }
        else {
            // not selected
            cell.accessoryType = .None
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = self.tenseArray[indexPath.section][indexPath.row]
        cell.selectionStyle = .None
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if selectedTimeVerbes.containsObject(indexPath) {
            // deselect
            selectedTimeVerbes.removeObject(indexPath)
           let cell2 = tableView.cellForRowAtIndexPath(indexPath)!
           if let text = cell2.textLabel?.text, n = arraySelection.indexOf(text){
               arraySelection.removeAtIndex(n)
            }
            
        }
        else {
            // select
            selectedTimeVerbes.removeAllObjects()
            selectedTimeVerbes.addObject(indexPath)
            arraySelection.append(self.tenseArray[indexPath.section][indexPath.row])
        }
 
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
    }
 

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuiz"{
            let controller = segue.destinationViewController as! QuizViewController
            print(arraySelection)
            if arraySelection[1] == "All 1000 Verbs!" || arraySelection[1] == "100 most Common Verbs" || arraySelection[1] == "Irregular Verbs"{
                let transfer = arraySelection[1]
                arraySelection[1] = arraySelection[0]
                arraySelection[0] = transfer
            }
            controller.arraySelection = arraySelection
            controller.verbArray = verbArray
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "Choose Options", message: "You have to choose both a Group of Verb and a Verb Tense", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: dismissAlert)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    func dismissAlert(sender: UIAlertAction) {
        
    }
    @IBAction func OK(sender: AnyObject) {
        print(arraySelection)
        let i = arraySelection.count
        if i == 2 && (arraySelection.contains("All 1000 Verbs!") || arraySelection.contains("100 most Common Verbs") || arraySelection.contains("Irregular Verbs")){
            performSegueWithIdentifier("showQuiz", sender: UIBarButtonItem.self)
        }else{
            showAlert()
        }
    }

}
