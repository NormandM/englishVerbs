//
//  AchievementsTableViewController.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-04.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class AchievementsTableViewController: UITableViewController {
    
    @IBOutlet var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var morePracticeButton: UIButton!
    @IBOutlet weak var returnToachievementButton: UIButton!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    let  typeOfQuizArray = ["Simple Past", "Past Participle"]
    var arrayVerbe = [[String: String]]()
    var imageNameArray = [[ "The Kiss", "The Street Pavers", "The Capture of Constantinople",  "The Girl with a Pearl Earring", "The Last Judgment", "Lot and his Daughters"], ["Sintflut", "Girl with Cat II", "A Child fallen out his cradle", "Tableau VII",  "Waterlilies", "Portrait of Arthur Rössler"]]
    var arrayPaintingInfo = [[String]]()
    var  quiz = [[String]]()
    var AllInfinitiveVerbs = [[[String]]]()
    var isFinishedArray = IsListOfVerbsFinished().arrayIsfinished
    let fonts = FontsAndConstraintsOptions()
    var startOverButton = UIButton()
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    var effect: UIVisualEffect!
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = visualEffect.effect
        visualEffect.effect = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over?", style: .plain, target: self, action: #selector(StartOver))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: fonts.normalBoldFont], for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(backToMenu))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: fonts.normalBoldFont], for: .normal)
        if let plistPath = Bundle.main.path(forResource: "ArtistesAndPaintings", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            arrayPaintingInfo = verbArray as! [[String]]
        }
        for n in 1...6{
            let listInfinif = ListInfinitif(arrayDictTestInfo: arrayVerbe, item: n).infinitif
            quiz.append(listInfinif)
        }
        AllInfinitiveVerbs = [quiz, quiz]
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        header.textLabel?.font = fonts.largeItaliqueFont
    }

    let MinHeight: CGFloat = 100.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                let tHeight = tableView.bounds.height
                let temp = tHeight/CGFloat(12)
                return temp > MinHeight ? temp : MinHeight
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return typeOfQuizArray[section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return typeOfQuizArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNameArray[section].count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height/25
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let indexPathToItemNumber = IndexPathToItemNumber(indexPath: indexPath)
        let itemFromTest = indexPathToItemNumber.paintingNumberFromTest
        let paintingAndTheirVerbs = PaintingsAndTheirVerbs(arrayDictTestInfo: arrayVerbe, arrayPainting: arrayPaintingInfo, item: itemFromTest)
        let painterName = paintingAndTheirVerbs.painter
        let paintingNumber = paintingAndTheirVerbs.paintingNumber
        cell.textLabel?.font = fonts.smallBoldFont
        cell.detailTextLabel?.font = fonts.smallItaliqueFont
        var paintingImage = UIImage()
        cell.textLabel?.textColor = UIColor.black
        var imageName = String()
        if isFinishedArray[Int(paintingNumber)! - 1]{
            cell.textLabel!.text = "See the Verb List and learn something about \(painterName)"
            imageName = imageNameArray[indexPath.section][indexPath.row]
            cell.isUserInteractionEnabled = true
        }else{
            imageName = "question2"
            cell.textLabel!.text = "You have not finished this verb list"
            cell.isUserInteractionEnabled = false
        }
        cell.detailTextLabel!.text = AllInfinitiveVerbs[indexPath.section][indexPath.row].joined(separator: ", ")
        if let image = UIImage(named: imageName) as UIImage?{
            paintingImage = image
            
        }else{print("There is no image")}
        cell.imageView?.image = paintingImage
        return cell
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpecificAchievement" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                navigationItem.backBarButtonItem?.tintColor = UIColor.white
                let indexPathToItemNumber = IndexPathToItemNumber(indexPath: indexPath)
                let item = indexPathToItemNumber.paintingNumber
                let itemFromTest = indexPathToItemNumber.paintingNumberFromTest
                let listOfInfinitif = ListInfinitif(arrayDictTestInfo: arrayVerbe, item: item)
                let infinitif =  listOfInfinitif.infinitif
                let listPastAndParticiple = listOfInfinitif.pastOrParticiple
                let paintingAndTheirVerbs = PaintingsAndTheirVerbs(arrayDictTestInfo: arrayVerbe, arrayPainting: arrayPaintingInfo, item: itemFromTest)
                let paintingName = paintingAndTheirVerbs.paintingName
                let painterBio = paintingAndTheirVerbs.painterBio
                let painterName = paintingAndTheirVerbs.painter
                let webAdress = paintingAndTheirVerbs.webAdress
                let painterAnniversary = paintingAndTheirVerbs.painterAnniversary
                let controller = segue.destination as! SpecificAchievementViewController
                controller.infinitif = infinitif
                controller.listPastOrparticiple = listPastAndParticiple
                controller.paintingName = paintingName
                controller.painterName = painterName
                controller.painterBio = painterBio
                controller.webAdress = webAdress
                controller.painterAnniversary = painterAnniversary
            }
            if segue.identifier == "showMainMenu" {
                
            }
        }
        // Pass the selected object to the new view controller.
    }
    @objc func StartOver(sender: UIButton!) {
        self.tableView.setContentOffset(.zero, animated: true)
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when + 1) {
            UIView.animate(withDuration: 0, delay: 0, animations: {
                
            }, completion: {finished in self.specialEffect()})
        }

    }
    func specialEffect() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        titleLabel.text = """
        You want to start over?
        Are you sure?
        """
        commentLabel.text = """
        All your achievments
        will be lost
        """
        self.tableView.isScrollEnabled = false
        SecondMessageView.showMessageView(view: view, messageView: messageView, visualEffect: blurEffectView, effect:effect, title: titleLabel, pastButton: morePracticeButton, participleButton: returnToachievementButton, consultAndLearnLabel: commentLabel, seeYourAchievementButton: nil)
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if messageView.isDescendant(of: view) {
            SecondMessageView.showMessageView(view: view, messageView: messageView, visualEffect: blurEffectView, effect:effect, title: titleLabel, pastButton: morePracticeButton, participleButton: returnToachievementButton, consultAndLearnLabel: commentLabel, seeYourAchievementButton: nil)
        }

        
    }
    @IBAction func needPracticeButtonPushed(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "quizNumber")
        UserDefaults.standard.set(0, forKey: "numberForQuizSimplePast")
        UserDefaults.standard.set(180, forKey: "numberForQuizPastParticiple")
        self.tableView.isScrollEnabled = true
        SecondMessageView.dismissMessageview(messageView: messageView, visualEffect: blurEffectView, effect: effect)
        isFinishedArray = IsListOfVerbsFinished().arrayIsfinished
        tableView.reloadData()
    }
    @objc func backToMenu(sender: UIButton!) {
        performSegue(withIdentifier: "specialMenu", sender: sender)
    }
    @IBAction func returnToAchievementPushed(_ sender: UIButton) {
        self.tableView.isScrollEnabled = true
        SecondMessageView.dismissMessageview(messageView: messageView, visualEffect: blurEffectView, effect: effect)
    }
    

}
