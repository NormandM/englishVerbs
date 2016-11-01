//
//  OptionModeVerbeViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-31.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import QuartzCore
class OptionModeVerbeViewController: UIViewController {
    @IBOutlet weak var mostVerbs: UILabel!
    @IBOutlet weak var irregularVerbs: UILabel!
    @IBOutlet weak var allVerbs: UILabel!
    var verbsArray: NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        mostVerbs.layer.masksToBounds = true
        irregularVerbs.layer.masksToBounds = true
        allVerbs.layer.masksToBounds = true
        mostVerbs.layer.cornerRadius = 15
        irregularVerbs.layer.cornerRadius = 15
        allVerbs.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    
    
    @IBAction func showTempDuVerbe(_ sender: Any) {
        
    }
    
    @IBAction func irregular(_ sender: Any) {
    }
     func allverbs(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTempVerbe"{
            let controller = segue.destination as! OptionListTableViewController
            controller.verbArray = verbsArray
        }
    }
 
    

}
