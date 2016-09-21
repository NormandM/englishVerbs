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
    
    
    enum TempsDeVerbe: String {
        case Present
        case Preterite
        case PresentPerfect
        case PastPerfect
        case PresentContinuous
        case PastContinuous
        case PastPerfectContinuous
        case FuturContinuous
        case PresentPerfectContinuous
        case FuturPerfectContinuous
        case Futur
        case FuturPerfect
        case Imperative
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Verb Tense"
        var n = 0
        while verbeInfinitif != verbArray[n][0] as! String{
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
 


    func chooseVerb() {
        let choixVerbe = AllVerbs(allVerbs: verbArray, n: index)
        if let indexPath = self.tableView.indexPathForSelectedRow {
            temps = tenseArray[indexPath.row]
            temps = temps.stringByReplacingOccurrencesOfString(" ", withString: "")
            if let tempsDeVerbe = TempsDeVerbe(rawValue: temps){
                switch tempsDeVerbe {
                case .Futur:
                    let verbeFinal = Futur(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                    
                case .FuturContinuous:
                    let verbeFinal = FuturContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .FuturPerfect:
                    let verbeFinal = FuturPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .FuturPerfectContinuous:
                    let verbeFinal = FuturPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Imperative:
                    let verbeFinal = Imperative(allVerbs: choixVerbe)
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                case .PastContinuous:
                    let verbeFinal = PastContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PastPerfect:
                    let verbeFinal = PastPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PastPerfectContinuous:
                    let verbeFinal = PastPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Present:
                    let verbeFinal = Present(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentContinuous:
                    let verbeFinal = PresentContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Preterite:
                    let verbeFinal = Preterite(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentPerfectContinuous:
                    let verbeFinal = PresentPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentPerfect:
                    let verbeFinal = PresentPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                }
            }
        }
    }
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showFinalVerb"{
            chooseVerb()
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
