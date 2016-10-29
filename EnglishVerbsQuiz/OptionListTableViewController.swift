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
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionArray[section]
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        arraySectionCount = sectionArray.count
        return arraySectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCount = tenseArray[section].count
        return arrayCount
    }
    // Next code is to enable checks for each cell selected
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).section == 0 {
            var n = 0
            while n < 3 {
                let indexPath2 = IndexPath(row: n, section: 0)
                let cellInd = tableView.cellForRow(at: indexPath2)
                cellInd?.accessoryType = .none
                n = n + 1
                    if let text = cellInd?.textLabel?.text, let i = arraySelection.index(of: text){
                        arraySelection.remove(at: i)
                    }

            }
        }else if (indexPath as NSIndexPath).section == 1 {
            var n = 0
            while n < 14 {
                let indexPath2 = IndexPath(row: n, section: 1)
                let cellInd = tableView.cellForRow(at: indexPath2)
                cellInd?.accessoryType = .none
                n = n + 1
                if let text = cellInd?.textLabel?.text, let i = arraySelection.index(of: text){
                    arraySelection.remove(at: i)
                }
            }

        }

        if selectedTimeVerbes.contains(indexPath) {
            // selected
            cell.accessoryType = .checkmark
            arraySelection.append(self.tenseArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row])
        }
        else {
            // not selected
            cell.accessoryType = .none
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = self.tenseArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.selectionStyle = .none
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if selectedTimeVerbes.contains(indexPath) {
            // deselect
            selectedTimeVerbes.remove(indexPath)
           let cell2 = tableView.cellForRow(at: indexPath)!
           if let text = cell2.textLabel?.text, let n = arraySelection.index(of: text){
               arraySelection.remove(at: n)
            }
            
        }
        else {
            // select
            selectedTimeVerbes.removeAllObjects()
            selectedTimeVerbes.add(indexPath)
            arraySelection.append(self.tenseArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row])
        }
 
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
    }
 

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuiz"{
            let controller = segue.destination as! QuizViewController
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
           if arraySelection[1] == "All 1000 Verbs!" || arraySelection[1] == "100 most Common Verbs" || arraySelection[1] == "Irregular Verbs"{
                let transfer = arraySelection[1]
                let transfer2 = arraySelection[0]
                arraySelection[1] = transfer2
                arraySelection[0] = transfer
           }
            controller.arraySelection = arraySelection
            controller.verbArray = verbArray
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "Choose Options", message: "You have to choose both a Group of Verb and a Verb Tense", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    @IBAction func OK(_ sender: AnyObject) {
        print(arraySelection)
        let i = arraySelection.count
        if i == 2 && (arraySelection.contains("All 1000 Verbs!") || arraySelection.contains("100 most Common Verbs") || arraySelection.contains("Irregular Verbs")){
            performSegue(withIdentifier: "showQuiz", sender: UIBarButtonItem.self)
        }else{
            showAlert()
        }
    }

}
