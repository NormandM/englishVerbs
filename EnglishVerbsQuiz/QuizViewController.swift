//
//  QuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification , object: nil)
        optionSlected()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// Mark: Function chhosing verb randomly according to chosen parameters
    func optionSlected () {
        arrayVerb = verbArray as! [[String]]
        if arraySelection.contains("100 most Common Verbs"){
            if let plistPath = NSBundle.mainBundle().pathForResource("100MostUseEnglishVerbs", ofType: "plist"),
                let verb100Verbs = NSArray(contentsOfFile: plistPath){
                let numberOfVerbs = verb100Verbs.count
                let random100 = Int(arc4random_uniform(UInt32(numberOfVerbs)))
                let array100Verbs = verb100Verbs as! [[String]]
                let verbChoisi100 = array100Verbs[random100][0]
                var n = 0
                for verb in arrayVerb {
                    if let index100Verbs = verb.indexOf(verbChoisi100){
                        index100Verbs
                        indexChoice = n
                    }
                    n = n + 1
                }
            }
            
        }else if arraySelection.contains("Irregular Verbs"){
            if let plistPath = NSBundle.mainBundle().pathForResource("IrregularVerbs", ofType: "plist"),
                let irregularVerb = NSArray(contentsOfFile: plistPath){
                let numberIrregular = irregularVerb.count
                indexChoice = Int(arc4random_uniform(UInt32(numberIrregular)))
                let arrayIrregular = irregularVerb as! [[String]]
                let verbeChoisiIrregular = arrayIrregular[indexChoice][0]
                print(verbeChoisiIrregular)
                var n = 0
                for verb in arrayVerb {
                    if let indexIrregular = verb.indexOf(verbeChoisiIrregular){
                        indexIrregular
                        indexChoice = n
                    }
                    n = n + 1
                }
            }
        }else if arraySelection.contains("All 1000 Verbs!"){
            let numberAllVerb = arrayVerb.count
            indexChoice = Int(arc4random_uniform(UInt32(numberAllVerb)))
        }
        
        toChooseVerb().chooseVerb(temps: arraySelection[1], indexChoice: indexChoice, verbArray: verbArray)
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
            premier.borderStyle = .None
            premier.backgroundColor = UIColor.clearColor()
            deuxieme.backgroundColor = UIColor.greenColor()
            deuxieme.userInteractionEnabled = true
            troisieme.borderStyle = .None
            troisieme.backgroundColor = UIColor.clearColor()
            sixieme.borderStyle = .None
            sixieme.backgroundColor = UIColor.clearColor()
            
        }

       
    }

//MARK: Notification for keyboard
    
     func keyboardWillShow(notification: NSNotification){

        
    }
    func textFieldShouldReturn(reponse: UITextField) -> Bool {
        if premier.editing{
            textFieldAnswer(premier, personne: first)
        }
        if deuxieme.editing{
            textFieldAnswer(deuxieme, personne: second)
        }
        if troisieme.editing{
            textFieldAnswer(troisieme, personne: third)
        }
        if quatrieme.editing{
            textFieldAnswer(quatrieme, personne: fourth)
        }
        if cinquieme.editing{
            textFieldAnswer(cinquieme, personne: fifth)
        }
        if sixieme.editing{
            textFieldAnswer(sixieme, personne: sixth)
        }

        if message == "true"{
            goodResponseMessage.text = "Great!"
        }else if message == "false" {
            let verb = verbeInfinitif.text
            let tense = arraySelection[1]
            let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: dataController.managedObjectContext) as! Item
            item.verb = verb
            item.tence = tense
            item.noBad = 1
            dataController.saveContext()
            performSegueWithIdentifier("showRightAnswer", sender: nil)
        }
        premier.resignFirstResponder()
        deuxieme.resignFirstResponder()
        troisieme.resignFirstResponder()
        quatrieme.resignFirstResponder()
        cinquieme.resignFirstResponder()
        sixieme.resignFirstResponder()
        return true
        
    }
    
//Mark: Function verifies in the User response is Good or Bad
    func textFieldAnswer(chosenTextField: UITextField, personne: String) -> String {
        if arraySelection[1] != "Imperative" {
            if chosenTextField.text == personne {
                premier.backgroundColor = UIColor.whiteColor()
                if personne == second {
                    deuxieme.text = second
                    deuxieme.backgroundColor = UIColor.whiteColor()
                }else if textIndex == 0{
                    deuxieme.backgroundColor = UIColor.greenColor()
                    deuxieme.userInteractionEnabled = true
                }
                if personne == third || second == third || first == third{
                    troisieme.text = third
                    troisieme.backgroundColor = UIColor.whiteColor()
                }else if textIndex < 2{
                    if textIndex != 0 || personne == fourth {
                        troisieme.backgroundColor = UIColor.greenColor()
                        troisieme.userInteractionEnabled = true
                    }
                }
                if personne == fourth || (second == fourth && textIndex > 0){
                    quatrieme.text = fourth
                    quatrieme.backgroundColor = UIColor.whiteColor()
                }
                if personne == fifth || (second == fifth && textIndex > 0) {
                    cinquieme.text = fifth
                    cinquieme.backgroundColor = UIColor.whiteColor()
                }
                if personne == sixth || (second == sixth && textIndex > 0) {
                    sixieme.text = sixth
                    sixieme.backgroundColor = UIColor.whiteColor()
                }
                textIndex = textIndex + 1
                print(troisieme.text)
                if troisieme.text != "" && cinquieme.text != "" {
                    print(message)
                    message = "true"
                }
            }else{
                message = "false"
            }
        }else{
            print(arraySelection[1])
            if chosenTextField.text == personne {
                if personne == second {
                    deuxieme.backgroundColor = UIColor.whiteColor()
                }
                if personne == fourth {
                    quatrieme.text = fourth
                    quatrieme.backgroundColor = UIColor.whiteColor()
                }else{
                    quatrieme.backgroundColor = UIColor.greenColor()
                    quatrieme.userInteractionEnabled = true
                }
                if personne == fifth {
                    cinquieme.text = fifth
                    cinquieme.backgroundColor = UIColor.whiteColor()
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

    @IBAction func another(sender: AnyObject) {
        optionSlected()
        textIndex = 0
        goodResponseMessage.text = ""
        message = ""
        if arraySelection[1] == "Imperative"{
            deuxieme.text = ""
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor.lightGrayColor()
            quatrieme.userInteractionEnabled = false
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor.lightGrayColor()
            cinquieme.userInteractionEnabled = false
            
            
        }else{
            premier.text = ""
            premier.backgroundColor = UIColor.greenColor()
            premier.userInteractionEnabled = true
            deuxieme.text = ""
            deuxieme.backgroundColor = UIColor.lightGrayColor()
            deuxieme.userInteractionEnabled = false
            troisieme.text = ""
            troisieme.backgroundColor = UIColor.lightGrayColor()
            troisieme.userInteractionEnabled = false
            quatrieme.text = ""
            quatrieme.backgroundColor = UIColor.lightGrayColor()
            quatrieme.userInteractionEnabled = false
            cinquieme.text = ""
            cinquieme.backgroundColor = UIColor.lightGrayColor()
            cinquieme.userInteractionEnabled = false
            sixieme.text = ""
            sixieme.backgroundColor = UIColor.lightGrayColor()
            sixieme.userInteractionEnabled = false
            
        }

    }


  
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRightAnswer"{
            let controller = segue.destinationViewController as! RightAnswerViewController
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
    }
    func showAlert () {
        let alertController = UIAlertController(title: "An example with the verb walk: ", message: hint, preferredStyle: .ActionSheet)
        alertController.popoverPresentationController?.sourceView = self.view
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    func dismissAlert(sender: UIAlertAction) {
        
    }

    @IBAction func hintButton(sender: AnyObject) {
        showAlert()
    }

}
