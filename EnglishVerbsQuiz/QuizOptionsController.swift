//
//  QuizOptionsController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

class QuizOptionsController: UITableViewController {
    let modeAndTemp = ModeAndTemp()
    var arrayVerb = [[String]]()
    var groupeVerbe = String()
    lazy var pattern = modeAndTemp.pattern
    lazy var temps = modeAndTemp.temp
    var selectedTimeVerbes = NSMutableSet()
    var arraySelectionTempsEtMode = [String]()
    var verbInfinitif = [String]()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    var quizButton = UIButton()
    var n = 0
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        return request
    }()
    let colorReference = ColorReference()
    override func viewDidLoad() {
        

    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = colorReference.specialGray
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        header.textLabel?.font = fontsAndConstraints.normalItaliqueFont
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Regular Verb Conjugation"
        quizButtonPosition ()
    }
    override func viewWillDisappear(_ animated: Bool) {
        quizButton.removeFromSuperview()
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        quizButton.removeFromSuperview()
        quizButtonPosition ()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return temps[section]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return temps.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pattern[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let celText = pattern[indexPath.section][indexPath.row]
        let attributedString = AttributedString(cellString:  celText)
        let finalString = attributedString.finalString
        cell.textLabel!.attributedText = finalString
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuizController"{
            verbInfinitif = ["Tous les verbes"]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = .white
            let controller = segue.destination as! QuizViewController
            controller.arrayVerb = arrayVerb
            controller.arraySelection = [[groupeVerbe], arraySelectionTempsEtMode]
            
        }
        if segue.identifier == "showQuizController"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = .white
            let controller = segue.destination as! QuizViewController
           // controller.arraySelectionTempsEtMode = arraySelectionTempsEtMode
            controller.arrayVerb = arrayVerb
        }
    }
    @objc func quizButtonPushed() {
        performSegue(withIdentifier: "showQuizController", sender: self)
    }
    func quizButtonPosition () {
        let yPosition = view.frame.height * 0.85
        let buttonWidth = view.frame.height * 0.1
        let xPosition = view.frame.width/2 - buttonWidth/2
        let buttonHeight = buttonWidth
        quizButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight))
        quizButton.layer.cornerRadius = quizButton.frame.height/2
        quizButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        quizButton.titleLabel?.textColor = UIColor.white
        quizButton.setTitle("Quiz", for: .normal)
        quizButton.titleLabel?.font = fontsAndConstraints.smallBoldFont
        self.navigationController?.view.addSubview(quizButton)
        quizButton.addTarget(self, action: #selector(quizButtonPushed), for: .touchUpInside)
    }
}
