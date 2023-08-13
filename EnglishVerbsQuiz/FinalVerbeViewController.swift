//
//  FinalVerbeViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-03.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class FinalVerbeViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    @IBOutlet weak var backgrounColorView: UIView!
    @IBOutlet weak var infinitif: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var premier: UILabel!
    @IBOutlet weak var deuxieme: UILabel!
    @IBOutlet weak var troisieme: UILabel!
    @IBOutlet weak var quatrieme: UILabel!
    @IBOutlet weak var cinquieme: UILabel!
    @IBOutlet weak var sixieme: UILabel!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    @IBOutlet weak var sixth: UILabel!
    @IBOutlet weak var listenLabel: UILabel!
    let screenSize: CGRect = UIScreen.main.bounds
    let fonts = FontsAndConstraintsOptions()
    var verbInfinitif = String()
    var indexTempsDeVerbe = Int()
    var temp = String()
    var arrayVerbe = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var n = 0
        for verb in arrayVerbe {
            if verb[0] == verbInfinitif {
               break
            }
            n = n + 1
        }
        let toChooseVerb = ToChooseVerb()
        _ = AllVerbs(allVerbs: arrayVerbe, n: n)
        let verb = toChooseVerb.chooseVerb(temps: temp, indexChoice: n , verbArray: arrayVerbe)
        listenLabel.text = "Click on the verb to hear the pronunciation"
        listenLabel.font = .systemFont(ofSize: 20, weight: .bold)
        listenLabel.textColor = .red
        premier.text = verb[0]
        deuxieme.text = verb[1]
        troisieme.text = verb[2]
        quatrieme.text = verb[3]
        cinquieme.text = verb[4]
        sixieme.text = verb[5]
        if verbInfinitif == "be"{
            if temp == "Present"{
                premier.text = "am"
                deuxieme.text = "are"
                troisieme.text = "is"
                quatrieme.text = "are"
                cinquieme.text = "are"
                sixieme.text = "are"
            }else if temp == "Preterite"{
                premier.text = "was"
                deuxieme.text = "were"
                troisieme.text = "was"
                quatrieme.text = "were"
                cinquieme.text = "were"
                sixieme.text = "were"
            }
            
        }
        infinitif.text = verbInfinitif.capitalizingFirstLetter()
        temps.text = temp.capitalizingFirstLetter()
        let choixDeLaPersonne1 = ChoixDuPronom(personne: "1", temp: temp)
        let choixDeLaPersonne2 = ChoixDuPronom(personne: "2", temp: temp)
        let choixDeLaPersonne3 = ChoixDuPronom(personne: "3", temp: temp)
        let choixDeLaPersonne4 = ChoixDuPronom(personne: "4", temp: temp)
        let choixDeLaPersonne5 = ChoixDuPronom(personne: "5", temp: temp)
        let choixDeLaPersonne6 = ChoixDuPronom(personne: "6", temp: temp)
        first.text = choixDeLaPersonne1.pronom
        second.text = choixDeLaPersonne2.pronom
        third.text = choixDeLaPersonne3.pronom
        fourth.text = choixDeLaPersonne4.pronom
        fifth.text = choixDeLaPersonne5.pronom
        sixth.text = choixDeLaPersonne6.pronom
        self.title = "Conjugated Verb"
    }
    override func viewWillAppear(_ animated: Bool) {
        backgrounColorView.layer.cornerRadius = 50
        infinitif.font = fonts.largeBoldFont
        temps.font = fonts.largeFont
        premier.font = fonts.smallItaliqueBoldFont
        deuxieme.font = fonts.smallItaliqueBoldFont
        troisieme.font = fonts.smallItaliqueBoldFont
        quatrieme.font = fonts.smallItaliqueBoldFont
        cinquieme.font = fonts.smallItaliqueBoldFont
        sixieme.font = fonts.smallItaliqueBoldFont
        first.font = fonts.smallFont
        second.font = fonts.smallFont
        third.font = fonts.smallFont
        fourth.font = fonts.smallFont
        fifth.font = fonts.smallFont
        sixth.font = fonts.smallFont
        let voiceStopped = Notification.Name("voiceStopped")
        notificationCenter.addObserver(self,selector: #selector(voiceDidTerminate),name: voiceStopped,object: nil)
        premier.clickLabel()
        deuxieme.clickLabel()
        troisieme.clickLabel()
        quatrieme.clickLabel()
        cinquieme.clickLabel()
        sixieme.clickLabel()

    }
    @objc func voiceDidTerminate(_ notification: NSNotification){
        premier.textColor = .black
        deuxieme.textColor = .black
        troisieme.textColor = .black
        quatrieme.textColor = .black
        cinquieme.textColor = .black
        sixieme.textColor = .black
    }
}

