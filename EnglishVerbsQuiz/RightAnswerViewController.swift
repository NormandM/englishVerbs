//
//  RightAnswerViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-15.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class RightAnswerViewController: UIViewController {
    
    @IBOutlet weak var infinitif: UILabel!
    @IBOutlet weak var temps: UILabel!
    
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
    
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    var fifth: String = ""
    var sixth: String = ""
    var tempsFinal: String = ""
    var infinitifFinal: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        infinitif.text = infinitifFinal
        temps.text = tempsFinal
        premier.text = first
        deuxieme.text = second
        troisieme.text = third
        quatrieme.text = fourth
        cinquieme.text = fifth
        sixieme.text = sixth
        
        if tempsFinal == "Imperative" {
            un.text = ""
            deux.text = "(you)"
            trois.text = ""
            quatre.text = "(we)"
            cinq.text = "(you)"
            six.text = ""
            premier.backgroundColor = UIColor(red: 165/255, green: 200/255, blue: 233/255, alpha: 1.0)
            troisieme.backgroundColor = UIColor(red: 165/255, green: 200/255, blue: 233/255, alpha: 1.0)
            sixieme.backgroundColor = UIColor(red: 165/255, green: 200/255, blue: 233/255, alpha: 1.0)
            premier.borderStyle = .none
            troisieme.borderStyle = .none
            sixieme.borderStyle = .none
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }

    
 

}
