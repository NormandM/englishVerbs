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
 
    @IBOutlet weak var commonVerbs: UITextView!
    @IBOutlet weak var irregularVerbs: UITextView!
    @IBOutlet weak var allVerbs: UITextView!
    @IBOutlet weak var def100Verbs: UITextView!
    @IBOutlet weak var defIrregularVerbs: UITextView!
    @IBOutlet weak var defAllVerbs: UITextView!
    
    var verbsArray: NSArray = []
    var groupeVerbe: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a group of verbs"
        def100Verbs.layer.masksToBounds = true
        def100Verbs.layer.cornerRadius = 10
        def100Verbs.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0)
        defIrregularVerbs.layer.masksToBounds  = true
        defIrregularVerbs.layer.cornerRadius = 10
        defIrregularVerbs.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0)
        defAllVerbs.layer.masksToBounds  = true
        defAllVerbs.layer.cornerRadius = 10
        defAllVerbs.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0)
        commonVerbs.layer.masksToBounds = true
        irregularVerbs.layer.masksToBounds = true
        allVerbs.layer.masksToBounds = true
        commonVerbs.layer.cornerRadius = 10
        irregularVerbs.layer.cornerRadius = 10
        allVerbs.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    @IBAction func showCommonVerbs(_ sender: Any) {
        groupeVerbe = "100 most Common Verbs"
        performSegue(withIdentifier: "showTempVerbe", sender: nil)
    }
    @IBAction func showIrregularVerbs(_ sender: Any) {
        groupeVerbe = "Irregular Verbs"
        performSegue(withIdentifier: "showTempVerbe", sender: nil)

    }
    @IBAction func showAllVerbs(_ sender: Any) {
        groupeVerbe = "All 1000 Verbs!"
        performSegue(withIdentifier: "showTempVerbe", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        if segue.identifier == "showTempVerbe"{
            let controller = segue.destination as! OptionListTableViewController
            controller.verbArray = verbsArray
            controller.groupeVerbe = groupeVerbe
        }
    }
 
    

}
