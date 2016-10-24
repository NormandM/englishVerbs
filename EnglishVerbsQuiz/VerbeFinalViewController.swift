//
//  VerbeFinalViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-20.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class VerbeFinalViewController: UIViewController {
    var personVerb: [String] = []
    var infinitif: String = ""
    var temps: String = ""
    var verbeInfinitif: String = ""
    var myMutableString = NSMutableAttributedString()
    

    @IBOutlet weak var nomDuVerbe: UILabel!
    @IBOutlet weak var tempsVerbe: UILabel!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    @IBOutlet weak var sixth: UILabel!

    func stringColor(person: String, pronom: String) {
        
        let position = pronom.characters.count
        let n = person.characters.count - position
        myMutableString = NSMutableAttributedString(string: person, attributes: [NSFontAttributeName:UIFont(name: "Helvetica neue", size: 18.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location: position, length: n))

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conjugated Verb"
        nomDuVerbe.text = "to \(verbeInfinitif)"
        tempsVerbe.text = temps

        if temps != "Imperative" {
            
            let premier = "I  " + personVerb[0]
            stringColor(premier, pronom: "I  ")
            first.text = premier
            first.attributedText = myMutableString
        
            let deuxieme = "you   " + personVerb[1]
            stringColor(deuxieme, pronom: "you   ")
            second.text = deuxieme
            second.attributedText = myMutableString
        
            let troisieme = "he/she/it   " + personVerb[2]
            stringColor(troisieme, pronom: "he/she/it   ")
            third.text = troisieme
            third.attributedText = myMutableString

            let quatrieme = "we   " + personVerb[3]
            stringColor(quatrieme, pronom: "we   ")
            fourth.text = quatrieme
            fourth.attributedText = myMutableString

            let cinquième = "you   " +  personVerb[4]
            stringColor(cinquième, pronom: "you   ")
            fifth.text = cinquième
            fifth.attributedText = myMutableString

            let sixieme = "they   " + personVerb[5]
            stringColor(sixieme, pronom: "they   ")
            sixth.text = sixieme
            sixth.attributedText = myMutableString
        }else{
            let deuxieme = "(you)  " + personVerb[1]
            stringColor(deuxieme, pronom: "(you)  ")
            second.text = deuxieme
            second.attributedText = myMutableString
            
            let troisieme = "(we) let's   " + personVerb[3]
            stringColor(troisieme, pronom: "(we) let's   ")
            third.text = troisieme
            third.attributedText = myMutableString
            
            let cinquieme = "(you)  " + personVerb[4]
            stringColor(cinquieme, pronom: "(you)  ")
            fifth.text = cinquieme
            fifth.attributedText = myMutableString
            
            first.text = ""
            fourth.text = ""
            sixth.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
