//
//  ContextuelMenuController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-22.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class ContextuelMenuController: UIViewController {
    @IBOutlet weak var MessageForVerbListMenu: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var contextualQuizButton: UIButton!
    @IBOutlet weak var contextualQuizStatisticsButton: UIButton!
    @IBOutlet weak var grandeJatte: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    var sentenceArray = [[String]]()
    let modeAndTemp = ModeAndTemp()
    var infiniveIrregular = [String]()
    var irregularVerbs = [[String]]()
    var arrayVerb: [[String]] = []
    let fonts = FontsAndConstraintsOptions()
    let colorReference = ColorReference()
    var effect: UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        effect = visualEffect.effect
        MessageForVerbListMenu.layer.cornerRadius = 5
        visualEffect.effect = nil
        
    }
    override func viewWillAppear(_ animated: Bool) {
        VerbListMenu.showMessageView(view: view, messageView: MessageForVerbListMenu, visualEffect: visualEffect, effect: effect, seeConjugatedVerb: contextualQuizButton, seeIrregularVerb: contextualQuizStatisticsButton)
        if UIDevice.current.orientation.isLandscape{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }else{
            ImageManager.choosImage(imageView: grandeJatte, imageName: "BigBen")
        }
        contextualQuizButton.titleLabel?.font = fonts.smallBoldFont
        contextualQuizStatisticsButton.titleLabel?.font = fonts.smallBoldFont
        backButton.titleLabel?.font = fonts.largeFont
        
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        VerbListMenu.showMessageView(view: view, messageView: MessageForVerbListMenu, visualEffect: visualEffect, effect: effect, seeConjugatedVerb: contextualQuizButton, seeIrregularVerb: contextualQuizStatisticsButton)
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .white
        if segue.identifier == "showContextQuiz"{
            let controller = segue.destination as! ContextuelQuizOptionController
            controller.sentenceArray = sentenceArray
            controller.arrayVerb = arrayVerb
            controller.infiniveIrregular = infiniveIrregular
        }
        if segue.identifier == "showContextQuizStatistic"{
            
        }
    }
}
