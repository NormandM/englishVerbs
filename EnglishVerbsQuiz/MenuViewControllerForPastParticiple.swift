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
    @IBOutlet weak var seeVourAchievementButton: UIButton!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var grandeJatte: UIImageView!
    var effect: UIVisualEffect!
    let fontsAndConstraints = FontsAndConstraintsOptions()
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
          //  UserDefaults.standard.set(330, forKey: "quizNumber")
          //   UserDefaults.standard.set(150, forKey: "numberForQuizSimplePast")
           //   UserDefaults.standard.set(330, forKey: "numberForQuizPastParticiple")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            IntroductionMessage.showMessageView(view: self.view, messageView: self.menuView, visualEffect: self.visualEffect, effect: self.effect, title: self.titleLabel, pastButton: self.pastButton, participleButton: self.participlaButton, consultAndLearnLabel: self.consultAndLearnLabel, seeYourAchievementButton: self.seeVourAchievementButton)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if UIDevice.current.orientation.isLandscape{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }else{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        IntroductionMessage.showMessageView(view: view, messageView: menuView, visualEffect: visualEffect, effect:effect, title: titleLabel, pastButton: pastButton, participleButton: participlaButton, consultAndLearnLabel: consultAndLearnLabel, seeYourAchievementButton: seeVourAchievementButton)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSimplePastQuiz" {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            backItem.tintColor = UIColor.white
            let typeOfQuiz = TypeOfQuiz.simplePast
            let controller = segue.destination as! PaintingViewController
            controller.typeOfQuiz = typeOfQuiz
        }
       if segue.identifier == "showPastParticiple"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            backItem.tintColor = UIColor.white
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
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            backItem.tintColor = UIColor.white
            let controller = segue.destination as! AchievementsTableViewController
            controller.arrayVerbe = arrayVerbe
        }



    }
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
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
        performSegue(withIdentifier: "showViewAchievement", sender: seeVourAchievementButton)
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
}


