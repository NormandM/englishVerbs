//
//  QuizResultViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuizResultViewController: UIViewController {
    var goodResponse: Int = 0
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var comment: UILabel!
    var testCompltete = UserDefaults.standard.bool(forKey: "testCompltete")        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCompltete = true
        UserDefaults.standard.set(self.testCompltete, forKey: "testCompltete")
        result.text = "\(goodResponse)/10"
        // Do any additional setup after loading the view.
        if goodResponse == 10{
            comment.text = "Perfect! "
        }else if goodResponse == 9 ||  goodResponse == 8 || goodResponse == 7{
            comment.text = "You are doing great!"
        }else{
            comment.text = "Try again!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
