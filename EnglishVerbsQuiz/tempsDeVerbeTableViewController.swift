//
//  tempsDeVerbeTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class tempsDeVerbeTableViewController: UITableViewController {
    let modeAndTemp = ModeAndTemp()
    lazy var modes = modeAndTemp.pattern
    lazy var temps = modeAndTemp.temp
    var verbInfinitif: String = ""
    var arrayVerbe: [[String]] = []
    var indexTempsDeVerbe = Int()
    var indexDuVerbe = Int()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        header.textLabel?.font = fontsAndConstraints.normalBoldFont
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     }
    let MinHeight: CGFloat = 50
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = tableView.frame.height - (navigationController?.navigationBar.frame.height)!
        let temp = tHeight/CGFloat(temps.count + 1)
        return temp > MinHeight ? temp : MinHeight
    }

    override func viewDidAppear(_ animated: Bool) {
        self.title = "Choose Verb Tense"
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = temps[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexTempsDeVerbe = indexPath.row
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeVerbeFinal"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                navigationItem.backBarButtonItem?.tintColor = .white
                let temp = temps[indexPath.row]
                let controller = segue.destination as! FinalVerbeViewController
                controller.indexTempsDeVerbe = indexTempsDeVerbe
                controller.verbInfinitif = verbInfinitif
                controller.arrayVerbe = arrayVerbe
                controller.temp = temp
            }
        }
    }

}
