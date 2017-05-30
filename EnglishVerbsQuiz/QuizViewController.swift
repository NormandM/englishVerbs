//
//  QuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class QuizViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let dataController = DataController.sharedInstance
    
    @IBOutlet weak var verbeInfinitif: UILabel!
    @IBOutlet weak var tempsVerbe: UILabel!
    @IBOutlet weak var un: UILabel!
    @IBOutlet weak var deux: UILabel!
    @IBOutlet weak var trois: UILabel!
    @IBOutlet weak var quatre: UILabel!
    @IBOutlet weak var cinq: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var goodResponseMessage: UILabel!
    @IBOutlet weak var premier: UITextField!
    @IBOutlet weak var deuxieme: UITextField!
    @IBOutlet weak var troisieme: UITextField!
    @IBOutlet weak var quatrieme: UITextField!
    @IBOutlet weak var cinquieme: UITextField!
    @IBOutlet weak var sixieme: UITextField!
    
    @IBOutlet weak var totalQuestion: UIProgressView!
    @IBOutlet weak var anotherOne: UIButton!
    
    
    @IBOutlet weak var textFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldTopConstraint2: NSLayoutConstraint!
    
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    var fenetre = UserDefaults.standard.bool(forKey: "fenetre")
    var testCompltete = UserDefaults.standard.bool(forKey: "testCompltete")

    
    enum TempsDeVerbe: String {
        case Present
        case Preterite
        case PresentPerfect
        case PastPerfect
        case PresentContinuous
        case PastContinuous
        case PastPerfectContinuous
        case FuturContinuous
        case PresentPerfectContinuous
        case FuturPerfectContinuous
        case Futur
        case FuturPerfect
        case Imperative
    }
    var hint: String = ""
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    var fifth: String = ""
    var sixth: String = ""
    var arrayVerb: [[String]] = []
    var arraySelection: [String] = []
    var verbArray: NSArray = []
    var indexChoice: Int = 0
    var textIndex: Int = 0
    var message: String = ""
    var progress: Float = 0.0
    var progressInt: Float = 0.0
    var goodResponse: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz"
        totalQuestion.progress = 0.0
        anotherOne.layer.masksToBounds = true
        anotherOne.layer.cornerRadius = 10
        testCompltete = false
        UserDefaults.standard.set(self.testCompltete, forKey: "testCompltete")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow , object: nil)
 
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)) , name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        optionSlected()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let reponse = UserDefaults.standard
        testCompltete = reponse.bool(forKey: "testCompltete")
        print(testCompltete)
        if testCompltete == true && fenetre == false {
            showAlert4()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRightAnswer" {
            let controller = segue.destination as! RightAnswerViewController
            premier.text = ""
            deuxieme.text = ""
            troisieme.text = ""
            quatrieme.text = ""
            cinquieme.text = ""
            sixieme.text = ""
            message = ""
            controller.first = first
            controller.second = second
            controller.third = third
            controller.fourth = fourth
            controller.fifth = fifth
            controller.sixth = sixth
            controller.tempsFinal = arraySelection[1]
            controller.infinitifFinal = verbeInfinitif.text!
        }
        if segue.identifier == "showQuizResult" {
            let controller = segue.destination as! QuizResultViewController
            controller.goodResponse = goodResponse
        }
    }

// MARK: All buttons
    @IBAction func hintButton(_ sender: AnyObject) {
        showAlert()
    }
    
    @IBAction func another(_ sender: AnyObject) {
        optionSlected()
        reinitializeTextFields()
        
    }

    
 /////////////////////////////////////////////////////////
 // MARK: All functions
    func reinitializeTextFields() {
        textIndex = 0
        goodResponseMessage.text = ""
        message = ""
        if arraySelection[1] == "Imperative"{
            deuxieme.text = ""
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor.lightGray
            quatrieme.isUserInteractionEnabled = false
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor.lightGray
            cinquieme.isUserInteractionEnabled = false
            
            
        }else{
            premier.text = ""
            premier.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 172/255, blue: 75/255, alpha: 1.0)
            premier.isUserInteractionEnabled = true
            deuxieme.text = ""
            deuxieme.backgroundColor = UIColor.lightGray
            deuxieme.isUserInteractionEnabled = false
            troisieme.text = ""
            troisieme.backgroundColor = UIColor.lightGray
            troisieme.isUserInteractionEnabled = false
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor.lightGray
            quatrieme.isUserInteractionEnabled = false
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor.lightGray
            cinquieme.isUserInteractionEnabled = false
            sixieme.text = ""
            sixieme.backgroundColor = UIColor.lightGray
            sixieme.isUserInteractionEnabled = false
            
        }

    }
// This is the function displaying the content for the Hint button
    func showAlert () {
        let alertController = UIAlertController(title: "An example with the verb walk: ", message: hint, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = tempsVerbe.frame
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    func resultQuiz () {

    }

    
//MARK: Function verifies in the User response is Good or Bad
    @discardableResult func textFieldAnswer(_ chosenTextField: UITextField, personne: String) -> String {
        if arraySelection[1] != "Imperative" {
            if chosenTextField.text == personne {
                premier.backgroundColor = UIColor.white
                if personne == second {
                    deuxieme.text = second
                    deuxieme.backgroundColor = UIColor.white
                }else if textIndex == 0{
                    deuxieme.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 172/255, blue: 75/255, alpha: 1.0)
                    deuxieme.isUserInteractionEnabled = true
                }
                if personne == third || second == third || first == third{
                    troisieme.text = third
                    troisieme.backgroundColor = UIColor.white
                }else if textIndex < 2{
                    if textIndex != 0 || personne == fourth {
                        troisieme.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 172/255, blue: 75/255, alpha: 1.0)
                        troisieme.isUserInteractionEnabled = true
                    }
                }
                if personne == fourth || (second == fourth && textIndex > 0){
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
                }else{
                    quatrieme.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 172/255, blue: 75/255, alpha: 1.0)
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
            let filePath = Bundle.main.path(forResource: "Incoming Text 01", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)
            
            progressClaculation()
            goodResponse = goodResponse + 1
            premier.isUserInteractionEnabled = false
            deuxieme.isUserInteractionEnabled = false
            troisieme.isUserInteractionEnabled = false
            quatrieme.isUserInteractionEnabled = false
            cinquieme.isUserInteractionEnabled = false
            sixieme.isUserInteractionEnabled = false

        }else if message == "false" {
            let filePath = Bundle.main.path(forResource: "Error Warning", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)
            
            progressClaculation()
            let verb = verbeInfinitif.text
            let tense = arraySelection[1]
            let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataController.managedObjectContext) as! Item
            item.verb = verb
            item.tence = tense
            item.noBad = 1
            dataController.saveContext()
            if progressInt != 10.0 {
                performSegue(withIdentifier: "showRightAnswer", sender: nil)
            }
        }
        premier.resignFirstResponder()
        deuxieme.resignFirstResponder()
        troisieme.resignFirstResponder()
        quatrieme.resignFirstResponder()
        cinquieme.resignFirstResponder()
        sixieme.resignFirstResponder()

        if progressInt == 10.0 {
            performSegue(withIdentifier: "showQuizResult", sender: nil)
        }
        

    }
    func textFieldShouldReturn(_ reponse: UITextField) -> Bool {
        if testReturnOrDone() {
            checkAnswer()
        }
        return true
        
    }
//MARK: Notification for keyboard
    
    func keyboardWillShow(_ notification: Notification){
        if troisieme.isEditing && UIDevice.current.userInterfaceIdiom == .pad && (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            UIView.animate(withDuration: 1.5, animations: {
                self.textFieldTopConstraint.constant = 1
                self.textFieldTopConstraint2.constant = 1
                self.view.layoutIfNeeded()
                
            })
        }
    }
    func keyboardWillHide (_ notification: Notification){
        if troisieme.isEditing && UIDevice.current.userInterfaceIdiom == .pad && (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            UIView.animate(withDuration: 1.5, animations: {
                self.textFieldTopConstraint.constant = 20
                self.textFieldTopConstraint2.constant = 20
                
                self.view.layoutIfNeeded()
            })
        }
        
    }
// Mark: Function chosing verb randomly according to chosen parameters
    func optionSlected () {
        arrayVerb = verbArray as! [[String]]
        if arraySelection.contains("100 most Common Verbs"){
            if let plistPath = Bundle.main.path(forResource: "100MostUseEnglishVerbs", ofType: "plist"),
                let verb100Verbs = NSArray(contentsOfFile: plistPath){
                let numberOfVerbs = verb100Verbs.count
                let random100 = Int(arc4random_uniform(UInt32(numberOfVerbs)))
                let array100Verbs = verb100Verbs as! [[String]]
                let verbChoisi100 = array100Verbs[random100][0]
                var n = 0
                for verb in arrayVerb {
                    if verb.index(of: verbChoisi100) != nil{
                        indexChoice = n
                    }
                    n = n + 1
                }
            }
            
        }else if arraySelection.contains("Irregular Verbs"){
            if let plistPath = Bundle.main.path(forResource: "IrregularVerbs", ofType: "plist"),
                let irregularVerb = NSArray(contentsOfFile: plistPath){
                let numberIrregular = irregularVerb.count
                indexChoice = Int(arc4random_uniform(UInt32(numberIrregular)))
                let arrayIrregular = irregularVerb as! [[String]]
                let verbeChoisiIrregular = arrayIrregular[indexChoice][0]
                var n = 0
                for verb in arrayVerb {
                    if verb.index(of: verbeChoisiIrregular) != nil{
                        indexChoice = n
                    }
                    n = n + 1
                }
            }
        }else if arraySelection.contains("All 1000 Verbs!"){
            let numberAllVerb = arrayVerb.count
            indexChoice = Int(arc4random_uniform(UInt32(numberAllVerb)))
        }
        first = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[0]
        second = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[1]
        third = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[2]
        fourth = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[3]
        fifth = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[4]
        sixth = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[5]
        hint = toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)[6]
        let verbTran = verbArray as! [[String]]
        verbeInfinitif.text = "to \(verbTran[indexChoice][0])"
        tempsVerbe.text = arraySelection[1]
        if arraySelection[1] == "Imperative"{
            un.text = ""
            deux.text = "(you)"
            trois.text = ""
            quatre.text = "(we)"
            cinq.text = "(you)"
            six.text = ""
            premier.borderStyle = .none
            premier.backgroundColor = UIColor.clear
            deuxieme.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 172/255, blue: 75/255, alpha: 1.0)
            deuxieme.isUserInteractionEnabled = true
            troisieme.borderStyle = .none
            troisieme.backgroundColor = UIColor.clear
            sixieme.borderStyle = .none
            sixieme.backgroundColor = UIColor.clear
            
        }
        if verbeInfinitif.text == "to be"{
            if arraySelection[1] == "Present"{
                first = "am"
                second = "are"
                third = "is"
                fourth = "are"
                fifth = "are"
                sixth = "are"
            }else if arraySelection[1] == "Preterite"{
                first = "was"
                second = "were"
                third = "was"
                fourth = "were"
                fifth = "were"
                sixth = "were"

            }else if arraySelection[1] == "Imperative"{
                second = "be"
                fourth = "let's be"
                fifth = "be"
            }
            
        }
    }
    @IBAction func unwindToLast(segue: UIStoryboardSegue) {
        optionSlected()
        reinitializeTextFields()
        if progressInt == 10.0{
            progressInt = 0.0
            progress = 0.0
            goodResponse = 0
            totalQuestion.progress = 0.0
            
        }
    }
    func progressClaculation() {
        progressInt = progressInt + 1
        progress = progressInt / 10
        totalQuestion.progress = progress
    }
    func testReturnOrDone() -> Bool {
        if premier.backgroundColor != UIColor.white || deuxieme.backgroundColor != UIColor.white || troisieme.backgroundColor != UIColor.white || quatrieme.backgroundColor != UIColor.white || cinquieme.backgroundColor != UIColor.white || sixieme.backgroundColor != UIColor.white {
            return true
        }else{
            return false
        }
    }
    
    @IBAction func done(_ sender: UIButton) {
        if testReturnOrDone() {
            checkAnswer()
        }
        
    }
    func showAlert4 () {
        
        let alert = UIAlertController(title: "English Verbs Quiz", message: "Please leave your comments. It is the only way I can improve this App.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK ", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction!) in self.rateApp(appId: "id1170835814") { success in
            print("RateApp \(success)")
            }}))
        alert.addAction(UIAlertAction(title: "Not now", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Do not show me this window again", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.fenetre = true; UserDefaults.standard.set(self.fenetre, forKey: "fenetre") }))
        self.present(alert, animated: true, completion: nil)
        testCompltete = false
        UserDefaults.standard.set(self.testCompltete, forKey: "testCompltete")

    }
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }

    
}
