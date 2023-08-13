//
//  QuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation
class QuizViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var typeOfVerbLabel: UILabel!
    @IBOutlet weak var verbTenseLabel: UILabel!
    @IBOutlet weak var un: UILabel!
    @IBOutlet weak var deux: UILabel!
    @IBOutlet weak var trois: UILabel!
    @IBOutlet weak var quatre: UILabel!
    @IBOutlet weak var cinq: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var goodResponseMessage: UILabel!
    var response = UITextField()
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var premier: UITextField!
    @IBOutlet weak var deuxieme: UITextField!
    @IBOutlet weak var troisieme: UITextField!
    @IBOutlet weak var quatrieme: UITextField!
    @IBOutlet weak var cinquieme: UITextField!
    @IBOutlet weak var sixieme: UITextField!
    @IBOutlet weak var tensePicker: UIPickerView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var pickerTitleLabel: UILabel!
    @IBOutlet weak var verbTensetTitle: UILabel!
    @IBOutlet weak var verbTypeTitle: UILabel!
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var oK1Button: UIButton!
    @IBOutlet weak var oK2Button: UIButton!
    @IBOutlet weak var oK3Button: UIButton!
    @IBOutlet weak var oK4Button: UIButton!
    @IBOutlet var messageView: UIView!
    var soundPlayer: SoundPlayer?
    var distanceFromTextField = CGFloat()
    var keyBoardRec = CGRect()
    var effect: UIVisualEffect!
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView = UIVisualEffectView()
    let modeAndTemp = ModeAndTemp()
    lazy var temps = modeAndTemp.temp
    var typeOfVerbs = [VerbForm.auxiliaryBe.rawValue, VerbForm.auxiliaryHave.rawValue, VerbForm.regularVerb.rawValue, VerbForm.irregularVerb.rawValue]
    var infinitive = String()
    var tenseSelected = String()
    var hint: String = ""
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    var fifth: String = ""
    var sixth: String = ""
    var arrayVerb: [[String]] = []
    var arraySelection: [[String]] = []
    var indexChoice: Int = 0
    var textIndex: Int = 0
    var message: String = ""
    let fonts = FontsAndConstraintsOptions()
    let colorReference = ColorReference()
    let textFieldDistances = TextFielDistances.firstPerson
    var distancePremier = CGFloat()
    var distanceDeuxieme = CGFloat()
    var distanceTroisieme = CGFloat()
    var distanceQuatrieme = CGFloat()
    var keyBoardHeight = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPlayer = SoundPlayer()
        self.title = "Quiz of Verb Forms"
        self.tensePicker.delegate = self
        self.tensePicker.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        goodResponseMessage.textColor = UIColor.black
        goodResponseMessage.font = fonts.normalItaliqueBoldFont
        premier.isUserInteractionEnabled = false
        deuxieme.isUserInteractionEnabled = false
        troisieme.isUserInteractionEnabled = false
        quatrieme.isUserInteractionEnabled = false
        cinquieme.isUserInteractionEnabled = false
        sixieme.isUserInteractionEnabled = false
        pickerViewSelected()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        verbTypeTitle.textColor = UIColor.white
        verbTypeTitle.font = fonts.normalFont
        verbTensetTitle.textColor = UIColor.white
        OkButtonSetUp.buttonHidden(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
        typeOfVerbLabel.font = fonts.largeBoldFont
        verbTenseLabel.font = fonts.largeFont
        typeOfVerbLabel.isHidden = true
        verbTenseLabel.isHidden = true
        commentLabel.font = fonts.normalItaliqueBoldFont
        commentLabel.text = "Understand the different verb forms and their combinations"
        un.font = fonts.normalFont
        deux.font = fonts.normalFont
        trois.font = fonts.normalFont
        quatre.font = fonts.normalFont
        cinq.font = fonts.normalFont
        six.font = fonts.normalFont
    }

    override func viewDidAppear(_ animated: Bool) {
        OkButtonSetUp.dimensionAndColour(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
        OkButtonSetUp.startQuizButtonSetUp(startQuizButton: startQuizButton)
        let buttonText = """
        Start
        Quiz
        """
        startQuizButton.setTitle(buttonText, for: .normal)
        goodResponseMessage.text = ""
        distancePremier = view.frame.size.height - (premier.frame.maxY + stackView.frame.minY)
        distanceDeuxieme =  view.frame.size.height - (deuxieme.frame.maxY + stackView.frame.minY)
        distanceTroisieme = view.frame.size.height - (troisieme.frame.maxY + stackView.frame.minY)
        distanceQuatrieme = view.frame.size.height - (quatrieme.frame.maxY + stackView.frame.minY)
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if messageView.isDescendant(of: view) {
            TensePickViewMessage.showPickerView(view: view, messageView: messageView, visualEffect: blurEffectView, effect: effect, title: pickerTitleLabel, okButton: okButton)
        }
        if startQuizButton.isDescendant(of: view) {
            OkButtonSetUp.startQuizButtonSetUp(startQuizButton: startQuizButton)
            OkButtonSetUp.dimensionAndColour(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return temps.count
        }
        return typeOfVerbs.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            tenseSelected = temps[row]
            return temps[row]
        }else{
            return typeOfVerbs[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            verbTenseLabel.text = temps[row]
        }else{
            let pickerChoice = modeAndTemp.pickerChoice(row: row, component: component)
            infinitive = pickerChoice.1
            typeOfVerbLabel.text = "To \(infinitive)"
        }
        optionSlected()
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for view in pickerView.subviews {
            if view.frame.size.height < 1 {
                var frame = view.frame
                frame.size.height = 1
                view.frame = frame
                view.backgroundColor = UIColor.white
            }
        }
        let pickerLabel = UILabel()
        var titleData = String()
        if component == 0 {
            titleData = temps[row]
        }else{
            titleData = typeOfVerbs[row]
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:(fonts.smallBoldFont ),NSAttributedString.Key.foregroundColor:UIColor.white])
        pickerLabel.textAlignment = .center
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }

 /////////////////////////////////////////////////////////
 // MARK: All functions
    func reinitializeTextFields() {
        textIndex = 0
        goodResponseMessage.text = ""
        message = ""
        let buttonText = """
            Try another
            one
            """
        OkButtonSetUp.buttonHidden(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
        startQuizButton.isHidden = false
        startQuizButton.setTitle(buttonText, for: .normal)
        if verbTenseLabel.text == "Imperative"{
            deuxieme.text = ""
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor.lightGray
            quatrieme.isUserInteractionEnabled = false
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor.lightGray
            cinquieme.isUserInteractionEnabled = false
        }else{
            premier.text = ""
            premier.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            premier.textColor = UIColor.black
            premier.isUserInteractionEnabled = true
            deuxieme.text = ""
            deuxieme.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            deuxieme.isUserInteractionEnabled = false
            deuxieme.textColor = UIColor.black
            troisieme.text = ""
            troisieme.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            troisieme.isUserInteractionEnabled = false
            troisieme.textColor = UIColor.black
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            quatrieme.isUserInteractionEnabled = false
            quatrieme.textColor = UIColor.black
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            cinquieme.isUserInteractionEnabled = false
            cinquieme.textColor = UIColor.black
            sixieme.text = ""
            sixieme.backgroundColor = UIColor(red: 178/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1.0)
            sixieme.isUserInteractionEnabled = false
            sixieme.textColor = UIColor.black
        }
    }

//MARK: Function verifies in the User response is Good or Bad
    @discardableResult func textFieldAnswer(_ chosenTextField: UITextField, personne: String) -> String {
        if verbTenseLabel.text != "Imperative" {
            if chosenTextField.text == personne{
                premier.backgroundColor = UIColor.white
                if personne == second {
                    deuxieme.text = second
                    deuxieme.backgroundColor = UIColor.white
                }else if textIndex == 0{
                    deuxieme.backgroundColor = UIColor.clear
                    deuxieme.isUserInteractionEnabled = true
                    oK1Button.isHidden = true
                    oK2Button.isHidden = false
                }
                if personne == third || second == third || first == third{
                    troisieme.text = third
                    troisieme.backgroundColor = UIColor.white
                }else if textIndex < 2{
                    if textIndex != 0 || personne == fourth {
                        troisieme.backgroundColor = UIColor.clear
                        troisieme.isUserInteractionEnabled = true
                        oK1Button.isHidden = true
                        oK2Button.isHidden = true
                        oK3Button.isHidden = false
                        oK4Button.isHidden = true
                    }
                }
                if personne == fourth  || (second == fourth && textIndex > 0){
                    quatrieme.text = fourth
                    quatrieme.backgroundColor = UIColor.white
                }
                if personne == fifth || (second == fifth && textIndex > 0) {
                    cinquieme.text = fifth
                    cinquieme.backgroundColor = UIColor.white
                }
                if personne == sixth || (second == sixth && textIndex > 0) {
                    sixieme.text = sixth
                    sixieme.backgroundColor = UIColor.white
                }
                textIndex = textIndex + 1
                if troisieme.text != "" && cinquieme.text != "" {
                    message = "true"
                }
            }else{
                message = "false"
            }
        }else{
            if chosenTextField.text == personne {
                if personne == second {
                    deuxieme.backgroundColor = UIColor.white
                    premier.isUserInteractionEnabled = false

                }
                if personne == fourth {
                    quatrieme.text = fourth
                    quatrieme.backgroundColor = UIColor.white
                    premier.isUserInteractionEnabled = false
                    oK1Button.isHidden = true
                    oK2Button.isHidden = true
                    oK3Button.isHidden = true
                    oK4Button.isHidden = false
                    
                }else{
                    quatrieme.backgroundColor = UIColor.white
                    quatrieme.isUserInteractionEnabled = true
                }
                if personne == fifth {
                    cinquieme.text = fifth
                    cinquieme.backgroundColor = UIColor.white
                    premier.isUserInteractionEnabled = false
                }
                if deuxieme.text != "" && quatrieme.text != "" {
                    message = "true"
                }
            }else{
                message = "false"
            }
        }
        return message
    }
    func checkAnswer(){
        if premier.isEditing{
            textFieldAnswer(premier, personne: first)
        }
        if deuxieme.isEditing{
            textFieldAnswer(deuxieme, personne: second)
        }
        if troisieme.isEditing{
            textFieldAnswer(troisieme, personne: third)
        }
        if quatrieme.isEditing{
            textFieldAnswer(quatrieme, personne: fourth)
        }
        if cinquieme.isEditing{
            textFieldAnswer(cinquieme, personne: fifth)
        }
        if sixieme.isEditing{
            textFieldAnswer(sixieme, personne: sixth)
        }
        if message == "true"{
            goodResponseMessage.text = "Great!"
            soundPlayer?.playSound(soundName: "chime_clickbell_octave_up", type: "mp3")
            premier.isUserInteractionEnabled = false
            deuxieme.isUserInteractionEnabled = false
            troisieme.isUserInteractionEnabled = false
            quatrieme.isUserInteractionEnabled = false
            cinquieme.isUserInteractionEnabled = false
            sixieme.isUserInteractionEnabled = false
            let buttonText = """
            Try another
            one
            """
            OkButtonSetUp.buttonHidden(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
            startQuizButton.isHidden = false
            startQuizButton.setTitle(buttonText, for: .normal)
            
            
        }else if message == "false" {
            soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
            premier.text = first
            deuxieme.text = second
            troisieme.text = third
            quatrieme.text = fourth
            cinquieme.text = fifth
            sixieme.text = sixth
            premier.textColor = colorReference.specialRed
            deuxieme.textColor = colorReference.specialRed
            troisieme.textColor = colorReference.specialRed
            quatrieme.textColor = colorReference.specialRed
            cinquieme.textColor = colorReference.specialRed
            sixieme.textColor = colorReference.specialRed
            premier.backgroundColor = UIColor.white
            deuxieme.backgroundColor = UIColor.white
            troisieme.backgroundColor = UIColor.white
            quatrieme.backgroundColor = UIColor.white
            cinquieme.backgroundColor = UIColor.white
            sixieme.backgroundColor = UIColor.white
            OkButtonSetUp.buttonHidden(oK1Button: oK1Button, oK2Button: oK2Button, oK3Button: oK3Button, oK4Button: oK4Button)
            goodResponseMessage.textColor = UIColor(red: 218/255, green: 69/255, blue: 49/255, alpha: 1.0)
            startQuizButton.isHidden = false
            //startQuizButton.setTitle("Try ", for: .normal)
            goodResponseMessage.text = "Sorry... See the right conjugation above."
        }
        premier.resignFirstResponder()
        deuxieme.resignFirstResponder()
        troisieme.resignFirstResponder()
        quatrieme.resignFirstResponder()
        cinquieme.resignFirstResponder()
        sixieme.resignFirstResponder()
    }
    func textFieldShouldReturn(_ response: UITextField) -> Bool {
        answerDone()
        return true
    }
//MARK: Notification for keyboard
    @objc func keyBoardWillShow(notification: Notification) {
        guard let keyBoardRec = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        keyBoardHeight = keyBoardRec.height
        if premier.isEditing && ((keyBoardRec.height - distancePremier + 5) > 0) {
            distanceFromTextField =  keyBoardRec.height - distancePremier + 5
        }else if deuxieme.isEditing && ((keyBoardRec.height - distanceDeuxieme + 5) > 0){
            distanceFromTextField =  keyBoardRec.height - distanceDeuxieme + 5
        }
        animateViewMoving(true, moveValue: distanceFromTextField)
    }
    @objc func keyboardWillHide (_ notification: Notification){
      //  self.view.frame.origin.y = 0
        distanceFromTextField = 0
    }
// Mark: Function chosing verb randomly according to chosen parameters
    func optionSlected () {
        reinitializeTextFields()
        tenseSelected = verbTenseLabel.text!
        if infinitive == "walk"{
            indexChoice = 960
        }else if infinitive == "be"{
            indexChoice = 47
        }else if infinitive == "do"{
            indexChoice = 257
        }else if infinitive == "have"{
            indexChoice = 376
        }
        first = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[0]
        second = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[1]
        third = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[2]
        fourth = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[3]
        fifth = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[4]
        sixth = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[5]
        hint = ToChooseVerb().chooseVerb(temps: tenseSelected, indexChoice: indexChoice, verbArray: arrayVerb)[6]
        verbTenseLabel.text = tenseSelected
        if tenseSelected == "Imperative"{
            un.text = ""
            deux.text = "(you)"
            trois.text = ""
            quatre.text = "(we)"
            cinq.text = "(you)"
            six.text = ""
            premier.text = ""
            troisieme.text = ""
            sixieme.text = ""
            premier.borderStyle = .none
            premier.backgroundColor = UIColor.clear
            deuxieme.backgroundColor = UIColor.clear
            deuxieme.isUserInteractionEnabled = true
            troisieme.borderStyle = .none
            troisieme.backgroundColor = UIColor.clear
            sixieme.borderStyle = .none
            sixieme.backgroundColor = UIColor.clear
        }else{
            un.text = "I"
            deux.text = "you"
            trois.text = "he/she/it"
            quatre.text = "we"
            cinq.text = "you"
            six.text = "they"
        }
        if infinitive == "be"{
            if tenseSelected == "Simple Present"{
                first = "am"
                second = "are"
                third = "is"
                fourth = "are"
                fifth = "are"
                sixth = "are"
            }else if tenseSelected == "Simple Past"{
                first = "was"
                second = "were"
                third = "was"
                fourth = "were"
                fifth = "were"
                sixth = "were"
            }else if tenseSelected == "Imperative"{
                second = "be"
                fourth = "let’s be"
                fifth = "be"
            }
        }
    }
    func testReturnOrDone() -> Bool {
        if premier.backgroundColor != UIColor.white || deuxieme.backgroundColor != UIColor.white || troisieme.backgroundColor != UIColor.white || quatrieme.backgroundColor != UIColor.white || cinquieme.backgroundColor != UIColor.white || sixieme.backgroundColor != UIColor.white {
            return true
        }else{
            return false
        }
    }
    @IBAction func done(_ sender: UIButton) {
        answerDone()
    }
    @IBAction func chooseTenseOptionPushed(_ sender: UIButton) {
        pickerViewSelected()
    }
    @IBAction func okButtonPushed(_ sender: UIButton) {
        TensePickViewMessage.dismissMessageview(messageView: messageView, visualEffect: blurEffectView, effect: effect)
        let selectedRow = tensePicker.selectedRow(inComponent: 0)
        let selectedRow2 = tensePicker.selectedRow(inComponent: 1)
        let pickerChoice = modeAndTemp.choice(position1: selectedRow, position2: selectedRow2)
        verbTenseLabel.text = pickerChoice.0
        infinitive = pickerChoice.2
        typeOfVerbLabel.text = "To \(infinitive)"
        optionSlected()
        if tenseSelected == "Imperative"{
            deuxieme.becomeFirstResponder()
            oK1Button.isHidden = true
            oK2Button.isHidden = false
        }else{
            premier.becomeFirstResponder()
            oK1Button.isHidden = false
        }
        premier.backgroundColor = UIColor.white
        if tenseSelected != "Imperative" {
            premier.borderStyle = .roundedRect
            troisieme.borderStyle = .roundedRect
            sixieme.borderStyle = .roundedRect
        }
        startQuizButton.isHidden = true
        typeOfVerbLabel.isHidden = false
        verbTenseLabel.isHidden = false
        distanceFromTextField = 0
    }
    func answerDone() {
        if testReturnOrDone() {
            checkAnswer()
        }
        var fromTextField = CGFloat()
        if tenseSelected != "Imperative"{
            if deuxieme.text == ""{
                deuxieme.becomeFirstResponder()
                if keyBoardHeight - distanceDeuxieme + 5 > 0 {
                    fromTextField =  keyBoardHeight - distanceDeuxieme + 5
                    distanceFromTextField = distanceFromTextField + fromTextField
                }
            }else if troisieme.text == ""{
                troisieme.becomeFirstResponder()
                if keyBoardHeight - distanceTroisieme + 5 > 0 {
                    fromTextField =  keyBoardHeight - distanceTroisieme + 5
                    distanceFromTextField = distanceFromTextField + fromTextField
                }
            }
        }else{
            if quatrieme.text == ""{
                quatrieme.becomeFirstResponder()
                oK2Button.isHidden = true
                oK4Button.isHidden = false
                if quatrieme.text != "" { oK4Button.isHidden = true}
                if keyBoardHeight - distanceQuatrieme + 5 > 0 {
                    fromTextField = keyBoardHeight - distanceQuatrieme + 5
                    distanceFromTextField = distanceFromTextField + fromTextField
                }
            }
        }
        animateViewMoving(true, moveValue: fromTextField)
    }

    func animateViewMoving(_ up: Bool, moveValue: CGFloat) {
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)

        UIView.animate(withDuration: movementDuration, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }
    func pickerViewSelected() {
        reinitializeTextFields()
        premier.textColor = UIColor.black
        deuxieme.textColor = UIColor.black
        troisieme.textColor = UIColor.black
        quatrieme.textColor = UIColor.black
        cinquieme.textColor = UIColor.black
        sixieme.textColor = UIColor.black
        commentLabel.isHidden = true
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effect = blurEffectView.effect
        effect = blurEffectView.effect
        view.addSubview(blurEffectView)
        goodResponseMessage.textColor = UIColor.black
        goodResponseMessage.isHidden = false
        TensePickViewMessage.showPickerView(view: view, messageView: messageView, visualEffect: blurEffectView, effect: effect!, title: pickerTitleLabel, okButton: okButton)
    }
}
