//
//  MenuOfVerbListViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-10.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class MenuOfVerbListViewController: UIViewController {
    @IBOutlet weak var MessageForVerbListMenu: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var seeConjugatedVerbButton: UIButton!
    @IBOutlet weak var seeIrregularVerbButton: UIButton!
    @IBOutlet weak var grandeJatte: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    var irregularVerbs = [[String]]()
    var infiniveIrregular = [String]()
    var arrayVerbe: [[String]] = []
    let fonts = FontsAndConstraintsOptions()
    let colorReference = ColorReference()
    var effect: UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        effect = visualEffect.effect
        MessageForVerbListMenu.layer.cornerRadius = 5
        visualEffect.effect = nil
        VerbListMenu.showMessageView(view: view, messageView: MessageForVerbListMenu, visualEffect: visualEffect, effect: effect, seeConjugatedVerb: seeConjugatedVerbButton, seeIrregularVerb: seeIrregularVerbButton)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if UIDevice.current.orientation.isLandscape{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }else{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }
        seeConjugatedVerbButton.titleLabel?.font = fonts.normalBoldFont
        seeIrregularVerbButton.titleLabel?.font = fonts.normalBoldFont
        backButton.titleLabel?.font = fonts.largeFont
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = colorReference.specialGray
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        VerbListMenu.showMessageView(view: view, messageView: MessageForVerbListMenu, visualEffect: visualEffect, effect: effect, seeConjugatedVerb: seeConjugatedVerbButton, seeIrregularVerb: seeIrregularVerbButton)
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        let colorReference = ColorReference()
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = colorReference.specialGreen
        if segue.identifier == "showVerbList"{
            let controller = segue.destination as! VerbListViewController
            controller.arrayVerbe = arrayVerbe
        }
        if segue.identifier == "showIrregularVerbs"{
            let controller = segue.destination as! IrregularVerbsTableViewController
            controller.irregularVerbs = irregularVerbs
            controller.infiniveIrregular = infiniveIrregular
            
        }
    }
}
