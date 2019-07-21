//
//  PaintingViewController.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-03-30.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation
class PaintingViewController: UIViewController {
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var questionLabelArray: [UILabel]!
    @IBOutlet var answerLabelArray: [UILabel]!
    @IBOutlet weak var verbBackGroundView: UIView!
    @IBOutlet weak var painting: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var messageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet var messageView: UIView!
    @IBOutlet weak var messageBottonConstraint:
    NSLayoutConstraint!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var seeAchievementsButton: UIButton!
    @IBOutlet weak var returnToMenuButton: UIButton!
    @IBOutlet weak var consultAndLearn: UILabel!
    let isFinished = IsListOfVerbsFinished().arrayIsfinished
    let colorReference = ColorReference()
    var effect: UIVisualEffect!
    var typeOfQuiz = TypeOfQuiz.simplePast
    var soundPlayer: SoundPlayer?
    var cardVerbArray = [[String: String]]()
    var cardArray = [Card]()
    var relationArray = [CardRelation]()
    var questionCount = Int()
    var goodAnswerPosition = Int()
    var badAnswerPosition = Int()
    var goodResponseButton = UIButton()
    var badResponseButton = UIButton()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    var position = [Int]()
    var arrayVerbe = [[String: String]]()
    var quizNumber = UserDefaults.standard.integer(forKey: "quizNumber")
    var numberForQuizPastParticiple =  UserDefaults.standard.integer(forKey: "numberForQuizPastParticiple")
    var numberForQuizSimplePast =  UserDefaults.standard.integer(forKey: "numberForQuizSimplePast")
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPlayer = SoundPlayer()
        effect = visualEffect.effect
        visualEffect.effect = nil
        if let plistPath = Bundle.main.path(forResource: "TestInfos", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            arrayVerbe = verbArray as! [[String: String]]
        }
        self.title = "Choose Verb Tenses"
    }
    override func viewWillAppear(_ animated: Bool) {
        verbBackGroundView.layer.cornerRadius = 50
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        switch typeOfQuiz {
        case .pastParticiple:
            quizNumber = numberForQuizPastParticiple
            self.title = "Choose the correct Past Participle"
        case.simplePast:
            quizNumber = numberForQuizSimplePast
            self.title = "Choose the correct Simple Past"
        }
        messageTopConstraint.constant = messageBottonConstraint.constant
        messageLabel.text = ""
        for label in questionLabelArray {
            label.font = fontsAndConstraints.smallFont
            label.text = " "
        }
        for label in answerLabelArray {
            label.font = fontsAndConstraints.smallItaliqueFont
            label.text = " "
        }
        messageLabel.font = fontsAndConstraints.normalItaliqueBoldFont
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.borderWidth = 15
        backgroundView.backgroundColor =  UIColor(red: 254/255, green: 177/255, blue: 95/255, alpha: 0.5)
        backgroundView.layer.borderColor = UIColor(red: 254/255, green: 177/255, blue: 95/255, alpha: 1.0).cgColor
        backgroundView.layer.cornerRadius = 15
        tryAgainButton.isHidden = true
        setUpCards()
    }
    override func viewDidAppear(_ animated: Bool) {
        let buttonText = """
        Try
        Again
        """
        tryAgainButton.titleLabel?.numberOfLines = 0
        tryAgainButton.titleLabel?.textAlignment = .center
        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.height/2
        tryAgainButton.setTitle(buttonText, for: .normal)
        tryAgainButton.titleLabel?.font = fontsAndConstraints.smallBoldFont
        tryAgainButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = colorReference.specialGray
         self.navigationController?.isNavigationBarHidden = false
    }

    func questionSelection(){
        let question = relationArray[questionCount]
        questionLabelArray[questionCount].textColor = UIColor.black
        let myText = Array(question.infinitive)
        let typeWriter = TypeWriter(verbLabel: questionLabelArray[questionCount], myText: myText, soundPlayer: soundPlayer, buttonPaintingDisplay: buttonPaintingDisplay)
        questionLabelArray[questionCount].font = fontsAndConstraints.smallItaliqueBoldFont
        soundPlayer?.playSound(soundName: "typewriter", type: "mp3")
        typeWriter.fireTimer()
    }
    func buttonPaintingDisplay() {
        let question = relationArray[questionCount]
        goodAnswerPosition = question.relation.0
        badAnswerPosition = question.relation.1
        let goodResponseText = question.goodCard.cardVerb
        let badResponseText = question.badCard.cardVerb
        goodResponseButton = cardButtons[goodAnswerPosition - quizNumber]
        badResponseButton = cardButtons[badAnswerPosition - quizNumber]
        goodResponseButton.isEnabled = true
        badResponseButton.isEnabled = true
        goodResponseButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        badResponseButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        goodResponseButton.tintColor = UIColor.white
        badResponseButton.tintColor = UIColor.white
        goodResponseButton.setTitle(goodResponseText, for: .normal)
        goodResponseButton.titleLabel?.font = fontsAndConstraints.smallFont
        badResponseButton.setTitle(badResponseText, for: .normal)
        badResponseButton.titleLabel?.font = fontsAndConstraints.smallFont
        goodResponseButton.layer.cornerRadius = 10
        goodResponseButton.setNeedsDisplay()
        badResponseButton.layer.cornerRadius = 10
        badResponseButton.setNeedsDisplay()
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAchievements" {
            let controller = segue.destination as! AchievementsTableViewController
            controller.arrayVerbe  = arrayVerbe
        }
    }
    @IBAction func cardPushed(_ sender: UIButton) {
        print("card pushed")
        if let cardNumberGood = cardButtons.firstIndex(of: sender){
            if cardNumberGood == goodAnswerPosition - quizNumber {
                let cardSelection = cardArray[goodAnswerPosition - quizNumber]
                let otherCardSelection = cardArray[badAnswerPosition - quizNumber]
                let image = cardSelection.cardImage
                goodResponseButton.setImage(image, for: .normal)
                goodResponseButton.isEnabled = false
                let otherImage = otherCardSelection.cardImage
                badResponseButton.setImage(otherImage, for: .normal)
                badResponseButton.isEnabled = false
                answerLabelArray[questionCount].text = cardSelection.cardVerb
                answerLabelArray[questionCount].font = fontsAndConstraints.smallBoldFont
                questionLabelArray[questionCount].textColor = UIColor.lightGray
                questionCount = questionCount + 1
                if questionCount <= relationArray.count - 1 {
                    questionSelection()
                }else{
                    switch typeOfQuiz {
                    ////////////////////////////////////////
                        
                    case .simplePast:
                        if cardSelection.paintingNumber == "6" {
                            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
                            let blurEffectView = UIVisualEffectView(effect: blurEffect)
                            blurEffectView.frame = view.bounds
                            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            view.addSubview(blurEffectView)
                            messageTitle.text = "Great Jobs!"
                            consultAndLearn.text = """
                            You know the simple past
                            of the main verbs.
                            """
                            MenuFinishedQuiz.showMessageView(view: view, messageView: messageView, visualEffect: blurEffectView, effect:effect, title: messageTitle, pastButton: seeAchievementsButton, participleButton: returnToMenuButton, consultAndLearnLabel: consultAndLearn, seeYourAchievementButton: nil)
                        }
                    case .pastParticiple:
                        if cardSelection.paintingNumber == "12" {
                            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
                            let blurEffectView = UIVisualEffectView(effect: blurEffect)
                            blurEffectView.frame = view.bounds
                            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            view.addSubview(blurEffectView)
                            messageTitle.text = "Great Jobs!"
                            consultAndLearn.text = """
                            You know the past participle
                            of the main verbs.
                            """
                            MenuFinishedQuiz.showMessageView(view: view, messageView: messageView, visualEffect: blurEffectView, effect:effect, title: messageTitle, pastButton: seeAchievementsButton, participleButton: returnToMenuButton, consultAndLearnLabel: consultAndLearn, seeYourAchievementButton: nil)
                            
                        }
                    }
                    incremantWhenListFinished()
                    UserDefaults.standard.set(quizNumber, forKey: "quizNumber")
                    messageLabel.text = "Great Job!"
                    soundPlayer?.playSound(soundName: "chime_clickbell_octave_up", type: "mp3")
                    tryAgainButton.isHidden = false
                    let textButton = """
                    Next
                    Verbs
                    """
                    tryAgainButton.titleLabel?.numberOfLines = 0
                    tryAgainButton.titleLabel?.textAlignment = .center
                    tryAgainButton.titleLabel?.lineBreakMode = .byWordWrapping
                    tryAgainButton.setTitle(textButton, for: .normal)
                }
                
            }else{
                tryAgainButton.setTitle("Try Again", for: .normal)
                for button in cardButtons {
                    button.setImage(nil, for: .normal)
                    button.setTitle(nil, for: .normal)
                    button.backgroundColor = UIColor.clear
                    button.layer.cornerRadius = 0
                    button.setNeedsDisplay()
                    button.isEnabled = false
                    soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
                    messageLabel.text = "Sorry... "
                }
                for label in answerLabelArray {
                    label.text = " "
                }
                for label in questionLabelArray{
                    label.text = " "
                }
                questionCount = 0
                tryAgainButton.isHidden = false
            }
        }
    }
    @IBAction func tryAgainPushed(_ sender: UIButton) {
        tryAgainButton.isHidden = true
        if questionCount < relationArray.count - 1 {
            questionSelection()
        }else{
            questionCount = 0
            for button in cardButtons {
                button.setImage(nil, for: .normal)
                button.setTitle(nil, for: .normal)
                button.backgroundColor = UIColor.clear
                button.layer.cornerRadius = 0
                button.setNeedsDisplay()
            }

            for label in answerLabelArray {
                label.text = " "
            }
            for label in questionLabelArray{
                label.text = " "
            }
            setUpCards()
        }
        messageLabel.text = ""
    }

    func setUpCards() {
        cardArray = []
        position = []
        cardVerbArray = []
        relationArray = []
        for n in quizNumber...29 + quizNumber{
            cardVerbArray.append(arrayVerbe[n])
            position.append(n)
        }
        for button in cardButtons {
            button.isEnabled = false
        }
        position.shuffle()
        for n in stride(from: 0, to: 29, by: 2) {
            let goodCardPosition = position[n]
            let badCardPosition = position[n+1]
            var cardGoodImage = UIImage()
            var cardBadImage = UIImage()
            if let image = UIImage(named: String(goodCardPosition)) as UIImage?{
                cardGoodImage = image
            }
            if let image = UIImage(named: String(badCardPosition)) as UIImage?{
                cardBadImage = image
            }
            let goodCard = Card(cardImage: cardGoodImage, cardPushed: false, cardVerb: cardVerbArray[n]["pastGoodAnswer"]!, cardPosition: goodCardPosition, cardGoodAnswer: true, paintingNumber:  cardVerbArray[n]["paintingNumber"]!)
            let badCard = Card(cardImage: cardBadImage, cardPushed: false, cardVerb: cardVerbArray[n + 1]["pastBadAnswer"]!, cardPosition: badCardPosition, cardGoodAnswer: false, paintingNumber: cardVerbArray[n]["paintingNumber"]!)
            let cardRelation = CardRelation(goodCard: goodCard, badCard: badCard, relation: (goodCardPosition, badCardPosition), infinitive: cardVerbArray[n]["infinitif"]!, paintingNumber: cardVerbArray[n]["paintingNumber"]!)
            cardArray.append(goodCard)
            cardArray.append(badCard)
            relationArray.append(cardRelation)
        }
        relationArray.shuffle()
        questionSelection()
        cardArray = cardArray.sorted{ $0.cardPosition < $1.cardPosition }
    }
    func incremantWhenListFinished() {
        quizNumber = quizNumber + 30
        switch typeOfQuiz {
        case .simplePast:
            numberForQuizSimplePast = quizNumber
        case .pastParticiple:
            numberForQuizPastParticiple = quizNumber
        }
        UserDefaults.standard.set(numberForQuizSimplePast, forKey: "numberForQuizSimplePast")
        UserDefaults.standard.set(numberForQuizPastParticiple, forKey: "numberForQuizPastParticiple")
    }
    
    @IBAction func returnToMenuPushed(_ sender: UIButton) {
    }
    @IBAction func seeAchievementWasPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "showAchievements", sender: self)
    }
}
