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
        if let plistPath = NSBundle.mainBundle().pathForResource("AllVerbs", ofType: "plist"),
            verbArray = NSArray(contentsOfFile: plistPath){
            verbsArray = verbArray
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

        if segue.identifier == "showVerbList"{
            let controller = segue.destinationViewController as! VerbListTableViewController
            controller.verbArray = verbsArray
        }else if segue.identifier == "showQuizVerbSelection" {
            let controller = segue.destinationViewController as! OptionListTableViewController
            controller.verbArray = verbsArray
   
            
        }
        
    }
}

