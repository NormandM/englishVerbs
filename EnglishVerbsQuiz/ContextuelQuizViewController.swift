//
//  ContextuelQuizViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-16.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ContextuelQuizViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tempsLabel: UILabel!
    @IBOutlet weak var suggestionButton: UIButton!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var uneAutreQuestionButton: UIButton!
    @IBOutlet weak var barreProgression: UIProgressView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet var helpView: UIView!
    @IBOutlet weak var titleHelpViewLabel: UILabel!
    @IBOutlet weak var rulesViewLabel: UILabel!
    @IBOutlet weak var regularOrIrregularVlewLabel: UILabel!
    @IBOutlet weak var doneViewButton: UIButton!
    @IBOutlet weak var rule1Label: UILabel!
    @IBOutlet weak var rule2Label: UILabel!
    @IBOutlet weak var rule3Label: UILabel!
    @IBOutlet weak var rule4Label: UILabel!
    @IBOutlet weak var rule5Label: UILabel!
    var soundPlayer: SoundPlayer?
    var distanceFromTextField = CGFloat()
    var effect: UIVisualEffect!
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    let fonts = FontsAndConstraintsOptions()
    let colorRefereences = ColorReference()
    var infiniveIrregular = [String]()
    var contextuelVerbs = [[String]]()
    var textFieldIsActivated = false
    var reponseBonne: String = ""
    var rightHintWasSelected = false
    var indexSentence = Int()
    var selectedSentences = [[String]]()
    var sentenceArray = [[String]]()
    var difficulté = DifficultyLevel.DIFFICILE
    var arrayVerb = [[String]]()
    var modeEtTemps = [[String]]()
    var userRespone = String()
    lazy var sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
    var progressInt = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPlayer = SoundPlayer()
        barreProgression.progress = 0.0
        for sentences in sentenceArray {
            for selection in modeEtTemps {
                if selection[0].caseInsensitiveCompare(sentences[0]) == .orderedSame {
                    selectedSentences.append(sentences)
                }
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        selectedSentences.shuffle()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        let fonts = FontsAndConstraintsOptions()
        self.title = "Conjugate the  Verb"
        tempsLabel.font = fonts.largeBoldFont
        suggestionButton.titleLabel?.font = fonts.smallItaliqueBoldFont
        sentenceLabel.font = fonts.normalItaliqueBoldFont
        verbTextField.font = fonts.normalFont
        uneAutreQuestionButton.titleLabel!.font = fonts.normalFont
        checkButton.titleLabel!.font = fonts.largeBoldFont
        doneViewButton.titleLabel!.font = fonts.normalBoldFont
        uneAutreQuestionButton.titleLabel?.font = fonts.smallItaliqueBoldFont
        let buttonText = """
        One More
        Verb!
        """
        uneAutreQuestionButton.titleLabel?.textAlignment = .center
        uneAutreQuestionButton.titleLabel?.numberOfLines = 0
        uneAutreQuestionButton.setTitle(buttonText, for: .normal)
        uneAutreQuestionButton.isHidden = true
        suggestionButton.isHidden = true
        choiceOfSentence()
    }
    override func viewDidAppear(_ animated: Bool) {
        uneAutreQuestionButton.layer.cornerRadius = uneAutreQuestionButton.frame.height / 2.0
        suggestionButton.layer.cornerRadius = suggestionButton.frame.height / 2.0
        distanceFromTextField = view.frame.size.height - verbTextField.frame.maxY
        verbTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(0, forKey: "thisQuizHintAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizGoodAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizBadAnswer")
        barreProgression.progress = 0.0
        progressInt = 0
        barreProgression.progress = 0.0
        selectionAutreQuestion()
    }
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        verbTextField.resignFirstResponder()
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if helpView.isDescendant(of: view) {
            MessageViewForHelp.showMessageView(view: view, messageView: helpView, visualEffect: blurEffectView, effect: effect, title: titleHelpViewLabel)
        }else{
            verbTextField.becomeFirstResponder()
        }
        distanceFromTextField = view.frame.size.height - verbTextField.frame.maxY
        uneAutreQuestionButton.layer.cornerRadius = uneAutreQuestionButton.frame.height / 2.0
        suggestionButton.layer.cornerRadius = suggestionButton.frame.height / 2.0
        uneAutreQuestionButton.setNeedsLayout()
        

        

    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    @objc func keyBoardWillChange(notification: Notification) {
        suggestionButton.isHidden = false
        uneAutreQuestionButton.isHidden = false
        guard let keyBoardRec = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if (keyBoardRec.height - distanceFromTextField + 5) > 0{
            let adjustement = keyBoardRec.height - distanceFromTextField + 5
            if notification.name == UIResponder.keyboardWillShowNotification && !textFieldIsActivated{
                textFieldIsActivated = true
                animateViewMoving(true, moveValue: adjustement)
                UIView.animate(withDuration: 3, animations: {
                    self.suggestionButton.transform = CGAffineTransform(translationX: 0, y: adjustement/2)}, completion: nil)
                UIView.animate(withDuration: 3, animations: {
                    self.tempsLabel.transform = CGAffineTransform(translationX: 0, y: adjustement/1.8)}, completion: nil)
                UIView.animate(withDuration: 3, animations: {
                    self.sentenceLabel.transform = CGAffineTransform(translationX: 0, y: adjustement/4)}, completion: nil)
            }else if notification.name == UIResponder.keyboardWillHideNotification{
                textFieldIsActivated = false
                animateViewMoving(true, moveValue: -adjustement)
                suggestionButton.transform = .identity
                tempsLabel.transform = .identity
                sentenceLabel.transform = .identity
            }
        }
    }
    @objc func textFieldShouldReturn(_ reponse: UITextField) -> Bool {
        afterUserResponse()
        return true
    }
    func choiceOfSentence () {
        sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
        questionInitialisation()
    }
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let controller = segue.destination as! ResultViewController
            controller.totalProgress = 10
        }
    }
    @IBAction func unwindToContextuekQuiz(segue: UIStoryboardSegue) {
        UserDefaults.standard.set(0, forKey: "thisQuizGoodAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizHintAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizBadAnswer")
        barreProgression.progress = 0.0
        progressInt = 0
        barreProgression.progress = 0.0
        indexSentence = 0
        selectionAutreQuestion()
    }
    func questionInitialisation() {
        verbTextField.text = ""
        let tempsDuVerbe = sentences.tempsDuVerbe
        reponseBonne = sentences.reponseBonne
        tempsLabel.text = tempsDuVerbe.capitalizingFirstLetter()
        sentenceLabel.attributedText = sentences.attributeQuestion
    }
    func afterUserResponse() {
        userRespone = verbTextField.text!
        verbTextField.resignFirstResponder()
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        checkButton.isHidden = true
        suggestionButton.isEnabled = false
        suggestionButton.backgroundColor = colorRefereences.specialGray
        sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
        let reponseEvaluation = ResponseEvaluation.evaluate(tempsVerb:  sentences.tempsDuVerbe, infinitif: sentences.infinitif, userResponse: userRespone, rightAnswer: sentences.reponseBonne, rightAnswer2: sentences.reponseBonne2, difficultyLevel: difficulté)
        sentenceLabel.textColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        verbTextField.textAlignment = .center
        verbTextField.borderStyle = .none
        verbTextField.font = fonts.largeBoldFont
        switch reponseEvaluation {
        case .good, .help:
            sentenceLabel.attributedText = sentences.attributeBonneReponse
            verbTextField.text = "Great Job!"
            soundPlayer?.playSound(soundName: "chime_clickbell_octave_up", type: "mp3")
        case .bad:
            verbTextField.text = "Sorry..."
            verbTextField.textColor = colorRefereences.specialRed
            soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
            sentenceLabel.attributedText = sentences.attributeMauvaiseReponse
        }
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        checkButton.isHidden = true
        progressInt = progressInt + 1
        barreProgression.progress = Float(progressInt)/Float(10)
        if progressInt == 10 {
            let when = DispatchTime.now() + 1.0 // change 2 to desired number of seconds
            uneAutreQuestionButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.performSegue(withIdentifier: "showResult", sender: nil)
            }
        }
        indexSentence = indexSentence + 1
        if indexSentence == selectedSentences.count - 1 {indexSentence = 0}
    }
    func selectionAutreQuestion() {
        suggestionButton.isEnabled = true
        suggestionButton.backgroundColor = colorRefereences.specialGreen
        checkButton.isHidden = false
        verbTextField.becomeFirstResponder()
        verbTextField.textColor = UIColor.black
        verbTextField.borderStyle = .roundedRect
        verbTextField.font = fonts.normalFont
        verbTextField.textAlignment = .left
        sentenceLabel.textColor = UIColor.black
        checkButton.isEnabled = true
        verbTextField.isEnabled = true
        verbTextField.textColor = UIColor.black
        verbTextField.text = ""
        uneAutreQuestionButton.isEnabled = true
        difficulté = .DIFFICILE
        rightHintWasSelected = false
        choiceOfSentence()
    }
    // MARK: Buttons
    @IBAction func uneAutreQuestionButtonPushed(_ sender: UIButton) {
        selectionAutreQuestion()
    }
    @IBAction func checkButton(_ sender: UIButton) {
        afterUserResponse()

    }
    @IBAction func suggestionButtonWasPressed(_ sender: UIButton) {
        suggestionButton.transform = .identity
        tempsLabel.transform = .identity
        sentenceLabel.transform = .identity
        difficulté = .FACILE
        self.navigationItem.setHidesBackButton(true, animated:true)
        verbTextField.resignFirstResponder()
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effect = blurEffectView.effect
        view.addSubview(blurEffectView)
        let rulesOfConjugation = RulesforConjugation(infinitif:  sentences.infinitifSeul, infiniveIrregular: infiniveIrregular, tempsDuVerbe: sentences.tempsDuVerbe)
        MessageViewForHelp.showMessageView(view: view, messageView: helpView, visualEffect: blurEffectView, effect: effect, title: titleHelpViewLabel)
        rulesViewLabel.text = """
        \(sentences.tempsDuVerbe)
        1. Conjugation rules:
        """
        rulesViewLabel.font = fonts.normalItaliqueFont
        var typeOfVerb = String()
        if rulesOfConjugation.isIrregularVerb{
            typeOfVerb = "an irregular verb"
        }else{
            typeOfVerb = "a regular verb"
        }
        let regularOrIrregular = """
        2. To \(sentences.infinitifSeul.capitalizingFirstLetter()):
               is an \(typeOfVerb)
        """
        let  attributedString2 = AttributedString2(cellString: regularOrIrregular)
        regularOrIrregularVlewLabel.attributedText = attributedString2.finalString
        if rulesOfConjugation.conjugationRule1 != "" {
            let attributtedString = AttributedString(cellString: rulesOfConjugation.conjugationRule1)
            rule1Label.attributedText = attributtedString.finalString
        }else{rule1Label.text = ""}
        if rulesOfConjugation.conjugationRule2 != "" {
            let attributtedString = AttributedString(cellString: rulesOfConjugation.conjugationRule2)
             rule2Label.attributedText = attributtedString.finalString
        }else{rule2Label.text = ""}
        if rulesOfConjugation.conjugationRule3 != "" {
            let attributtedString = AttributedString(cellString: rulesOfConjugation.conjugationRule3)
            rule3Label.attributedText = attributtedString.finalString
        }else{rule3Label.text = ""}
        if rulesOfConjugation.conjugationRule4 != "" {
            let attributtedString = AttributedString(cellString: rulesOfConjugation.conjugationRule4)
            rule4Label.attributedText = attributtedString.finalString
        }else{rule4Label.text = ""}
        if rulesOfConjugation.conjugationRule5 != "" {
            let attributtedString = AttributedString(cellString: rulesOfConjugation.conjugationRule5)
            rule5Label.attributedText = attributtedString.finalString
        }else{rule5Label.text = ""}
    }
    @IBAction func doneWasPressed(_ sender: UIButton) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        MessageViewForHelp.dismissMessageview(view: view, messageView: helpView, visualEffect: blurEffectView, effect: effect)
        verbTextField.becomeFirstResponder()
    }
    
}

