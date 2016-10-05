//
//  QuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var verbeInfinitif: UILabel!
    @IBOutlet weak var tempsVerbe: UILabel!
    @IBOutlet weak var un: UILabel!
    @IBOutlet weak var deux: UILabel!
    @IBOutlet weak var trois: UILabel!
    @IBOutlet weak var quatre: UILabel!
    @IBOutlet weak var cinq: UILabel!
    @IBOutlet weak var six: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification , object: nil)
        
        arrayVerb = verbArray as! [[String]]
        if arraySelection.contains("100 most Common Verbs"){
            if let plistPath = NSBundle.mainBundle().pathForResource("100MostUseEnglishVerbs", ofType: "plist"),
                verb100Verbs = NSArray(contentsOfFile: plistPath){
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
                irregularVerb = NSArray(contentsOfFile: plistPath){
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
        
        chooseVerb()
        verbeInfinitif.text = "to \(verbArray[indexChoice][0] as! String)"
        tempsVerbe.text = arraySelection[1]
    }
//MARK: NOTIFICATION FOR KEYBOARD
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func chooseVerb() {
        let choixVerbe = AllVerbs(allVerbs: verbArray, n: indexChoice)
        
            var temps = arraySelection[1]
            temps = temps.stringByReplacingOccurrencesOfString(" ", withString: "")
            if let tempsDeVerbe = TempsDeVerbe(rawValue: temps){
                switch tempsDeVerbe {
                case .Futur:
                    let verbeFinal = Futur(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                    
                case .FuturContinuous:
                    let verbeFinal = FuturContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .FuturPerfect:
                    let verbeFinal = FuturPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .FuturPerfectContinuous:
                    let verbeFinal = FuturPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Imperative:
                    let verbeFinal = Imperative(allVerbs: choixVerbe)
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                case .PastContinuous:
                    let verbeFinal = PastContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PastPerfect:
                    let verbeFinal = PastPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PastPerfectContinuous:
                    let verbeFinal = PastPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Present:
                    let verbeFinal = Present(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentContinuous:
                    let verbeFinal = PresentContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .Preterite:
                    let verbeFinal = Preterite(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentPerfectContinuous:
                    let verbeFinal = PresentPerfectContinuous(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                case .PresentPerfect:
                    let verbeFinal = PresentPerfect(allVerbs: choixVerbe)
                    first = verbeFinal.first
                    second = verbeFinal.second
                    third = verbeFinal.third
                    fourth = verbeFinal.fourth
                    fifth = verbeFinal.fifth
                    sixth = verbeFinal.sixth
                }
            }
    }


    
     func keyboardWillShow(notification: NSNotification){

        
    }
    func textFieldShouldReturn(reponse: UITextField) -> Bool {
        if premier.editing{
            print(textFieldAnswer(premier, personne: first))
        }
        if deuxieme.editing{
            print(textFieldAnswer(deuxieme, personne: second))
        }
        if troisieme.editing{
            print(textFieldAnswer(troisieme, personne: third))
        }
        if quatrieme.editing{
            print(textFieldAnswer(quatrieme, personne: fourth))
        }
        if cinquieme.editing{
            print(textFieldAnswer(cinquieme, personne: fifth))
        }
        if sixieme.editing{
            print(textFieldAnswer(sixieme, personne: sixth))
        }

        premier.resignFirstResponder()
        deuxieme.resignFirstResponder()
        troisieme.resignFirstResponder()
        quatrieme.resignFirstResponder()
        cinquieme.resignFirstResponder()
        sixieme.resignFirstResponder()
        return true
        
    }
    func textFieldAnswer(chosenTextField: UITextField, personne: String) -> String {
        let message: String
        if chosenTextField.text == personne {
            if first == second{
                deuxieme.text = second
            }
            if first == third{
                troisieme.text = third
            }
            if first == fourth{
                quatrieme.text = fourth
            }
            if first == fifth{
                cinquieme.text = fifth
            }
            if first == sixth{
                sixieme.text = sixth
            }
            message = "Good Answer"
        }else{
            message = personne
        }
        return message
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
