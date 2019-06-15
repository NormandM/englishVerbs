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
 
    @IBOutlet weak var verbConjugationForm: UITextView!
    @IBOutlet weak var pastAndPastParticiple: UITextView!
    @IBOutlet weak var allVerbs: UITextView!
    @IBOutlet weak var defVerbConjugation: UITextView!
    @IBOutlet weak var defPastAndPastParticiple: UITextView!
    @IBOutlet weak var defAllVerbs: UITextView!
    var verbsArray = [[String]]()
    var groupeVerbe: String = ""
    let fonts = FontsAndConstraintsOptions()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a group of verbs"
        defVerbConjugation.layer.masksToBounds = true
        defVerbConjugation.layer.cornerRadius = 10
        defVerbConjugation.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        defPastAndPastParticiple.layer.masksToBounds  = true
        defPastAndPastParticiple.layer.cornerRadius = 10
        defPastAndPastParticiple.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        defAllVerbs.layer.masksToBounds  = true
        defAllVerbs.layer.cornerRadius = 10
        defAllVerbs.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        verbConjugationForm.layer.masksToBounds = true
        pastAndPastParticiple.layer.masksToBounds = true
        allVerbs.layer.masksToBounds = true
        verbConjugationForm.layer.cornerRadius = 10
        pastAndPastParticiple.layer.cornerRadius = 10
        allVerbs.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        verbConjugationForm.font = fonts.smallBoldFont
        pastAndPastParticiple.font = fonts.smallBoldFont
        allVerbs.font = fonts.normalBoldFont
        defVerbConjugation.font = fonts.smallItaliqueFont
        defPastAndPastParticiple.font = fonts.smallItaliqueFont
        
    }
    // MARK: - Navigation
    @IBAction func showCommon(_ sender: UITapGestureRecognizer) {
            groupeVerbe = "100 most Common Verbs"
            performSegue(withIdentifier: "showTempVerbe", sender: sender)
    }
    
    @IBAction func showPastParticiple(_ sender: UITapGestureRecognizer) {
        groupeVerbe = "Irregular Verbs"
        performSegue(withIdentifier: "showPastParticipleMenu", sender: sender)
    }
    @IBAction func showAllVerbs(_ sender: UITapGestureRecognizer) {
        groupeVerbe = "All 1000 Verbs!"
        performSegue(withIdentifier: "showTempVerbe", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        if segue.identifier == "showTempVerbe"{
            let controller = segue.destination as! QuizOptionsController
            controller.arrayVerb = verbsArray
            controller.groupeVerbe = groupeVerbe
        }
        if segue.identifier == "showPastParticipleMenu"{
            let controller = segue.destination as! MenuViewControllerForPastParticiple
        }
    }
}
