//
//  ListeVerbTenseTableViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-18.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ListeVerbTenseTableViewController: UITableViewController {
    
    var verbeInfinitif: String = ""
    var verbArray: NSArray = []
    var index = 0
    var temps: String = ""
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    var fifth: String = ""
    var sixth: String = ""
    
    var tenseArray: [String] = ["Present", "Preterite", "Present Perfect", "Past Perfect", "Present Continuous", "Past Continuous", "Past Perfect Continuous", "Futur Continuous", "Present Perfect Continuous", "Futur Perfect Continuous", "Futur", "FuturPerfect", "Imperative"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Verb Tense"
        var n = 0
        let arrayTrans = verbArray as! [[String]]
        while verbeInfinitif != arrayTrans[n][0]{
            n = n + 1
        }
        index = n
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tenseArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = self.tenseArray[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            temps = tenseArray[indexPath.row]
        if segue.identifier == "showFinalVerb"{
            first = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[0]
            print(first)
            second = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[1]
            third = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[2]
            fourth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[3]
            fifth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[4]
            sixth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[5]
            
            let controller = segue.destinationViewController as! VerbeFinalViewController
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
            let personVerb = [first, second, third, fourth, fifth, sixth]
            controller.personVerb = personVerb
            controller.temps = temps
            controller.verbeInfinitif = verbeInfinitif
            }
        }
    }
 

}
