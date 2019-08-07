//
//  ContextuelQuizOptionController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-15.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit

class ContextuelQuizOptionController: UITableViewController {
    var sentenceArray = [[String]]()
    let modeAndTemp = ModeAndTemp()
    var infiniveIrregular = [String]()
    lazy var temps = modeAndTemp.tempContexte
    var arrayVerb = [[String]]()
    var selectedTimeVerbes = NSMutableSet()
    var arraySelectionTempsEtMode = [[String]]()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.textLabel?.font = fontsAndConstraints.normalBoldFont
        header.alpha = 1.0 //make the header transparent
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Choose Verb Tenses"
    }
    let MinHeight: CGFloat = 50
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = tableView.frame.height - (navigationController?.navigationBar.frame.height)!
        let temp = tHeight/CGFloat(temps.count + 1)
        return temp > MinHeight ? temp : MinHeight
    }
    
    // MARK: - Table view data source
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  temps.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = temps[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if selectedTimeVerbes.contains(indexPath) {
            // selected
            cell.accessoryType = .checkmark
        }
        else {
            // not selected
            cell.accessoryType = .none
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedTimeVerbes.contains(indexPath) {
            // deselect
            selectedTimeVerbes.remove(indexPath)
            let cell2 = tableView.cellForRow(at: indexPath)!
            var textArray = [String]()
            if let text = cell2.textLabel?.text{
                textArray = [text]
            }
            if let n = arraySelectionTempsEtMode.firstIndex(of: textArray){
                arraySelectionTempsEtMode.remove(at: n)
            }
        }
        else {
            // select
            selectedTimeVerbes.add(indexPath)
            arraySelectionTempsEtMode.append([temps[indexPath.row]])
        }
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContextuelQuiz"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = .white
            let controller = segue.destination as! ContextuelQuizViewController
            controller.modeEtTemps = arraySelectionTempsEtMode
            controller.arrayVerb = arrayVerb
            controller.sentenceArray = sentenceArray
            controller.infiniveIrregular = infiniveIrregular
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "You must choose at least one verb tense.", message: nil, preferredStyle: .alert)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = tableView.rectForHeader(inSection: 1)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func OK(_ sender: UIBarButtonItem) {
        var i = 0
        i = arraySelectionTempsEtMode.count
        if i == 0{
            showAlert()
        }else{
            performSegue(withIdentifier: "showContextuelQuiz", sender: UIBarButtonItem.self)
        }
    }
}

