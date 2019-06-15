//
//  SpecificAchievementViewController.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-09.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class SpecificAchievementViewController: UIViewController {
    var infinitif =  [String]()
    var paintingName = String()
    var listPastOrparticiple = [String]()
    var painterBio = String()
    var painterName = String()
    var webAdress = String()
    var painterAnniversary = String()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var painterNameLabel: UILabel!
    @IBOutlet weak var paintingImageView: UIImageView!
    @IBOutlet weak var biotTextView: UITextView!
    @IBOutlet weak var pastOrParticleLabel: UILabel!
    @IBOutlet var infinitifArray: [UILabel]!
    @IBOutlet var pastOrParticipleArray: [UILabel]!
    let fontsAndConstraints = FontsAndConstraintsOptions()
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = UIImage(named: paintingName) as UIImage?{
            paintingImageView.image = image
        }
        var n = 0
        for label in infinitifArray {
            label.text = infinitif[n]
            label.font = fontsAndConstraints.smallFont
            label.textColor = UIColor.black
            n = n + 1
        }
        n = 0
        for label in pastOrParticipleArray {
            label.text = listPastOrparticiple[n]
            label.font = fontsAndConstraints.smallFont
            label.textColor = UIColor.black
            n = n + 1
        }
        
         biotTextView.text = painterBio
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = paintingName
        painterNameLabel.text = """
        \(painterName)
        (\(painterAnniversary))
        """
        painterNameLabel.font = fontsAndConstraints.largeBoldFont
        biotTextView.font = fontsAndConstraints.normalFont
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    override func viewDidAppear(_ animated: Bool) {
        biotTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
