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
    var arraySelection: [[String]] = []
    var arraySlectedTense: [String] = []
    var verbArray: NSArray = []
    var arraySectionCount: Int = 0
    var arrayCount: Int = 0
    var groupeVerbe: String = ""
    let oKIem = UIBarButtonItem()
    
    let tenseArray: [String] =  ["Present", "Preterite", "Present Perfect", "Past Perfect", "Present Continuous", "Past Continuous", "Past Perfect Continuous", "Futur Continuous", "Present Perfect Continuous", "Futur Perfect Continuous", "Futur", "Futur Perfect", "Imperative"]
    // Changing backgroung colors of the header of sections
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Verb Tense"
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tenseArray.count
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.selectionStyle = .none
//        cell.textLabel!.text = self.tenseArray[(indexPath as NSIndexPath).row]
//        return cell
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = self.tenseArray[indexPath.row]
        cell.selectionStyle = .none
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
   
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if selectedTimeVerbes.contains(indexPath) {
            // selected
            cell.accessoryType = .checkmark
        }
        else {
            // not selected
            cell.accessoryType = .none
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedTimeVerbes.contains(indexPath) {
            // deselect
            selectedTimeVerbes.remove(indexPath)
            let cell2 = tableView.cellForRow(at: indexPath)!
            if let text = cell2.textLabel?.text, let n = arraySlectedTense.index(of: text){
                arraySlectedTense.remove(at: n)
            }
            
        }
        else {
            // select
            selectedTimeVerbes.add(indexPath)
            arraySlectedTense.append(self.tenseArray[indexPath.row])
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
            let temps = arraySlectedTense
            arraySelection = [[groupeVerbe], temps]
            controller.arraySelection = arraySelection
            controller.verbArray = verbArray
            
        }
    }
 

    @IBAction func okSegue(_ sender: UIBarButtonItem) {
        print(arraySlectedTense)
        performSegue(withIdentifier: "showQuiz", sender: UIBarButtonItem.self)
    }
 

}
