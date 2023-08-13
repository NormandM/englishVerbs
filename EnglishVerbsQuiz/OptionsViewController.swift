//
//  OptionsViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import StoreKit
class OptionsViewController: UIViewController{
    @IBOutlet weak var listeDesVerbes: UILabel!
    @IBOutlet weak var quizDeBase: UILabel!
    @IBOutlet weak var quizContextuel: UILabel!
    let fonts = FontsAndConstraintsOptions()
    let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
    var arrayVerbe: [[String]] = []
    var contextuelVerbs = [[String]]()
    var irregularVerbs = [[String]]()
    var infiniveIrregular = [String]()
    var launchCount =  UserDefaults.standard.integer(forKey: "launchCount")
    override func viewDidLoad() {
        super.viewDidLoad()
        if launchCount >= 10 {
            if let scene = UIApplication.shared.currentScene {
                SKStoreReviewController.requestReview(in: scene)
            }
            UserDefaults.standard.set(0, forKey: "launchCount")
        }

        if let plistPath = Bundle.main.path(forResource: "AllVerbs", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            arrayVerbe = verbArray as! [[String]]
        }
        if let plistPath = Bundle.main.path(forResource: "ContextualVerbs", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            contextuelVerbs = verbArray as! [[String]]
        }
        if let plistPath = Bundle.main.path(forResource: "IrregularVerbs", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            irregularVerbs = verbArray as! [[String]]
        }
        for verb in irregularVerbs {
            infiniveIrregular.append(verb[0])
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.title = "Choose an Option"
        let fonts = FontsAndConstraintsOptions()
        listeDesVerbes.font = fonts.smallItaliqueBoldFont
        quizDeBase.font = fonts.smallItaliqueBoldFont
        quizDeBase.text = """
        BASIC QUIZ
        AND KNOWLEDGE
        """
        quizContextuel.font = fonts.smallItaliqueBoldFont
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuForVerbList"{
            let controller = segue.destination as! MenuOfVerbListViewController
            controller.arrayVerbe = arrayVerbe
            controller.irregularVerbs = irregularVerbs
            controller.infiniveIrregular = infiniveIrregular
        }else if segue.identifier == "showOptions"{
            let controller = segue.destination as! MenuViewControllerForPastParticiple
            controller.arrayVerbes = arrayVerbe
            controller.irregularVerbs = irregularVerbs
            controller.infiniveIrregular = infiniveIrregular
        }else if segue.identifier == "showContextuelMenu"{
            let controller = segue.destination as! ContextuelMenuController
            controller.sentenceArray = contextuelVerbs
            controller.arrayVerb = arrayVerbe
            controller.infiniveIrregular = infiniveIrregular
        }

        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {

    }
}
