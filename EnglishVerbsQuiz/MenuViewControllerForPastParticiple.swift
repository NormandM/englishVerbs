//
//  MenuViewController.swift
//  PaintingsAndArtists
//
//  Created by Normand Martin on 2018-05-23.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
class MenuViewControllerForPastParticiple: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var participlaButton: UIButton!
    @IBOutlet weak var consultAndLearnLabel: UILabel!
    @IBOutlet weak var borderLabel: UILabel!
    @IBOutlet weak var studyAndlearnTitle: UILabel!
    @IBOutlet weak var studyAnLearnComment: UILabel!
    @IBOutlet weak var irregularVerbButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var borderLabelStudyAndLearn: UILabel!
    @IBOutlet weak var verbFormButton: UIButton!
    @IBOutlet weak var achievementButton: UIButton!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var grandeJatte: UIImageView!
    var irregularVerbs = [[String]]()
    var infiniveIrregular = [String]()
    var effect: UIVisualEffect!
    var groupeVerbe = String()
    var arrayVerbes = [[String]]()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    let colorReference = ColorReference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        effect = visualEffect.effect
        menuView.layer.cornerRadius = 5
        visualEffect.effect = nil
        if !(quizAlreadyStarted(quizNumber: "quizNumber")){
            UserDefaults.standard.set(0, forKey: "quizNumber")
            UserDefaults.standard.set(0, forKey: "numberForQuizSimplePast")
            UserDefaults.standard.set(180, forKey: "numberForQuizPastParticiple")
        }
        IntroductionMessage.showMessageView(view: self.view, messageView: self.menuView, visualEffect: self.visualEffect, effect: self.effect, title: self.titleLabel, pastButton: self.pastButton, participleButton: self.participlaButton, consultAndLearnLabel: self.consultAndLearnLabel, seeYourAchievementButton: self.achievementButton)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if UIDevice.current.orientation.isLandscape{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }else{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }
        borderLabel.layer.borderColor = colorReference.specialGray.cgColor
        borderLabel.layer.borderWidth = 2
        borderLabelStudyAndLearn.layer.borderWidth = 2
        borderLabelStudyAndLearn.layer.borderColor = colorReference.specialGray.cgColor
        let buttonTitle = """
        Verbs Forms
        and their
        Combinations
        """
        verbFormButton.setTitle(buttonTitle, for: .normal)
        verbFormButton.titleLabel?.font = fontsAndConstraints.smallItaliqueBoldFont
        verbFormButton.titleLabel?.numberOfLines = 0
        verbFormButton.titleLabel?.textAlignment = .center
        irregularVerbButton.titleLabel?.font = fontsAndConstraints.smallItaliqueBoldFont
        studyAndlearnTitle.font = fontsAndConstraints.smallBoldFont
        studyAndlearnTitle.textColor = colorReference.specialGray
        studyAnLearnComment.font = fontsAndConstraints.smallFont
        studyAnLearnComment.textColor = colorReference.specialGray
        backButton.titleLabel?.font = fontsAndConstraints.largeFont
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = colorReference.specialGray
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        IntroductionMessage.showMessageView(view: view, messageView: menuView, visualEffect: visualEffect, effect:effect, title: titleLabel, pastButton: pastButton, participleButton: participlaButton, consultAndLearnLabel: consultAndLearnLabel, seeYourAchievementButton: achievementButton)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        backItem.tintColor = colorReference.specialGreen
        if segue.identifier == "showSimplePastQuiz" {
            let typeOfQuiz = TypeOfQuiz.simplePast
            let controller = segue.destination as! PaintingViewController
            controller.typeOfQuiz = typeOfQuiz
        }
       if segue.identifier == "showPastParticiple"{
            let typeOfQuiz = TypeOfQuiz.pastParticiple
            let controller = segue.destination as! PaintingViewController
            controller.typeOfQuiz = typeOfQuiz

        }
        if segue.identifier == "showViewAchievement"{
            var arrayVerbe = [[String : String]]()
            if let plistPath = Bundle.main.path(forResource: "TestInfos", ofType: "plist"),
                let verbArray = NSArray(contentsOfFile: plistPath){
                arrayVerbe = verbArray as! [[String: String]]
            }
            let controller = segue.destination as! AchievementsTableViewController
            controller.arrayVerbe = arrayVerbe
        }
        if segue.identifier == "verbRules" {
            let controller = segue.destination as! QuizOptionsController
            controller.arrayVerb = arrayVerbes
            controller.groupeVerbe = groupeVerbe
        }
        if segue.identifier == "showIrregularVerbs" {
            let controller = segue.destination as! IrregularVerbsTableViewController
            controller.irregularVerbs = irregularVerbs
            controller.infiniveIrregular = infiniveIrregular
        }
    }
    func userAlreadyExist(credit: String) -> Bool {
        return UserDefaults.standard.object(forKey: credit) != nil
    }
    @IBAction func simplePastButtonwasPushed(_ sender: UIButton) {
        let numberForQuizSimplePast =  UserDefaults.standard.integer(forKey: "numberForQuizSimplePast")
        if numberForQuizSimplePast > 179 {
            showAlertQuizPastFinished()
        }else{
            performSegue(withIdentifier: "showSimplePastQuiz", sender: sender)
        }
    }
    @IBAction func PastParticipleButtonwasPushed(_ sender: UIButton) {
        let numberForQuizPastParticiple =  UserDefaults.standard.integer(forKey: "numberForQuizPastParticiple")
        if numberForQuizPastParticiple > 359 {
            showAlertQuizParticipleFinished()
        }else{
            performSegue(withIdentifier: "showPastParticiple", sender: sender)
        }
    }
    @IBAction func achievementsButtonWasPushed(_ sender: Any) {
         seeAchievements()
    }
    func seeAchievements() {
        performSegue(withIdentifier: "showViewAchievement", sender: achievementButton)
    }
    @IBAction func verbFormPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "verbRules", sender: self)
    }
    @IBAction func irregularVerbPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "showIrregularVerbs", sender: self)
    }
    
    
    func quizAlreadyStarted(quizNumber: String) -> Bool {
        return UserDefaults.standard.object(forKey: quizNumber) != nil
    }
    func showAlertQuizParticipleFinished () {
        let alert = UIAlertController(title: "You have completed Past Participle Quiz", message: "what would you like to do?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "See Achievements", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.seeAchievements()}))
        let okAction = UIAlertAction(title: "Return to menu", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertQuizPastFinished () {
        let alert = UIAlertController(title: "You have completed the Simple Past Quiz", message: "what would you like to do?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "See Achievements", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.seeAchievements()}))
        let okAction = UIAlertAction(title: "Return to menu", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func backButtonPushed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


