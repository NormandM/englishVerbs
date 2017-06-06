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
    
    var tenseArray: [String] = ["Present", "Preterite", "Present Perfect", "Past Perfect", "Present Continuous", "Past Continuous", "Past Perfect Continuous", "Futur Continuous", "Present Perfect Continuous", "Futur Perfect Continuous", "Futur", "Futur Perfect", "Imperative"]
    
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
        if let indexPath = self.tableView.indexPathForSelectedRow {
            temps = tenseArray[(indexPath as NSIndexPath).row]
        if segue.identifier == "showFinalVerb"{
            first = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[0]
            second = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[1]
            third = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[2]
            fourth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[3]
            fifth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[4]
            sixth = toChooseVerb().chooseVerb(temps: temps, indexChoice: index, verbArray: verbArray)[5]
            
            if verbeInfinitif == "be"{
                if temps == "Present"{
                    first = "am"
                    second = "are"
                    third = "is"
                    fourth = "are"
                    fifth = "are"
                    sixth = "are"
                }else if temps == "Preterite"{
                    first = "was"
                    second = "were"
                    third = "was"
                    fourth = "were"
                    fifth = "were"
                    sixth = "were"
                }

            }
            let controller = segue.destination as! VerbeFinalViewController
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
