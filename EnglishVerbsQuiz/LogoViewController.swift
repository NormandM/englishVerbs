//
//  LogoViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-27.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation

class LogoViewController: UIViewController {
    @IBOutlet weak var appsLabel: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var appsLabel2: UILabel!
    var soundPlayer: SoundPlayer?
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        soundPlayer = SoundPlayer()
        let appsLabelFrame  = appsLabel.frame
        let appsLabel2Frame = appsLabel2.frame
        let maxXappsLabel = appsLabelFrame.maxX
        let maxXappsLabel2 = appsLabel2Frame.maxX
        soundPlayer?.playSound(soundName: "Acoustic Trio", type: "wav")
        UIView.animate(withDuration: 3, animations: {
            self.appsLabel2.transform = CGAffineTransform(translationX: maxXappsLabel - maxXappsLabel2 , y: 0)}, completion: {finished in self.completionAnimation()})
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func completionAnimation() {
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when + 1) {
            self.performSegue(withIdentifier: "showOption", sender: (Any).self)
        }
    }

}
