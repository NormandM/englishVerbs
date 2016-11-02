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
    @IBOutlet weak var defMostVerbe: UILabel!
    @IBOutlet weak var defIrregular: UILabel!
    @IBOutlet weak var defAllVerbs: UILabel!
    
    var verbsArray: NSArray = []
    var groupeVerbe: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a group of verbs"
        
        defMostVerbe.layer.masksToBounds = true
        defIrregular.layer.masksToBounds = true
        defAllVerbs.layer.masksToBounds = true
        mostVerbs.layer.masksToBounds = true
        irregularVerbs.layer.masksToBounds = true
        allVerbs.layer.masksToBounds = true
        defMostVerbe.layer.cornerRadius = 10
        defIrregular.layer.cornerRadius = 10
        defAllVerbs.layer.cornerRadius = 10
        mostVerbs.layer.cornerRadius = 10
        irregularVerbs.layer.cornerRadius = 10
        allVerbs.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    
    
    @IBAction func showTempDuVerbe(_ sender: Any) {
        groupeVerbe = "100 most Common Verbs"
        performSegue(withIdentifier: "showTempVerbe", sender: nil)    }
    
    @IBAction func irregular(_ sender: Any) {
        groupeVerbe = "Irregular Verbs"
        performSegue(withIdentifier: "showTempVerbe", sender: nil)
    }
    
     func allverbs(_ sender: Any) {
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
