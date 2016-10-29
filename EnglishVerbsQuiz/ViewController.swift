//
//  ViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-17.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var verbsArray: NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose an Option"
        if let plistPath = Bundle.main.path(forResource: "AllVerbs", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            verbsArray = verbArray
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

        if segue.identifier == "showVerbList"{
            let controller = segue.destination as! VerbListTableViewController
            controller.verbArray = verbsArray
        }else if segue.identifier == "showQuizVerbSelection" {
            let controller = segue.destination as! OptionListTableViewController
            controller.verbArray = verbsArray
            
        }else if segue.identifier == "showListController"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

            let controller = segue.destination as! ListController
            controller.verbArray = verbsArray
            
        }
    }
}

