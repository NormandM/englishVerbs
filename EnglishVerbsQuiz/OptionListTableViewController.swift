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
    var groupeVerbe: String = ""
    
    
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel!.text = self.tenseArray[(indexPath as NSIndexPath).row]
        return cell
    }
    
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuiz"{
            let controller = segue.destination as! QuizViewController
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let temps = tenseArray[(indexPath as NSIndexPath).row]
                arraySelection = [groupeVerbe, temps]
                controller.arraySelection = arraySelection
                controller.verbArray = verbArray
            }
        }
    }

}
