//
//  StatistiqueTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-11.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData
import Charts
class StatistiqueTableViewController: UITableViewController {
   
    let modeAndTemp = ModeAndTemp()
    lazy var temps = modeAndTemp.tempContexte
    var itemFinal: [[String]] = []
    let dataController = DataController.sharedInstance
    let fonts = FontsAndConstraintsOptions()
    var  arrayFinal = [[(Int,Int,Int, String)]]()
    var arrayStringFinal = [[String]]()
    var resultArray = [(Int, Int, Int, String)]()
    var resultStringArray = [String]()
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verbeInfinitif", ascending: true)
        return request
    }()
    var deleteStatisticsButton = UIButton()
    var items: [Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingData()
     }
    override func viewWillAppear(_ animated: Bool) {
        deleteStatisticButtonSetUp()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Contextual Quiz Statistics"

    }
    override func viewWillDisappear(_ animated: Bool) {
       deleteStatisticsButton.removeFromSuperview()
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        deleteStatisticsButton.removeFromSuperview()
        deleteStatisticButtonSetUp()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StatistiqueViewCell
        cell.labelForCell.font = fonts.normalItaliqueBoldFont
        cell.labelForCell.textAlignment = .center
        cell.labelForCell.numberOfLines = 0
        cell.labelForCell.text = """
        \(temps[indexPath.row]):
        \(resultStringArray[indexPath.row])
        """
        let entrieBon = Double(resultArray[indexPath.row].0)
        let entrieAide = Double(resultArray[indexPath.row].1)
        let entrieMal = Double(resultArray[indexPath.row].2)
        let pieChartSetUp = PieChartSetUp(entrieBon: entrieBon, entrieMal: entrieMal, entrieAide: entrieAide, pieChartView: cell.viewForCell )
        cell.viewForCell.data = pieChartSetUp.piechartData
        return cell
    }
//////////////////////////////////////
// MARK: All Buttons and actions
//////////////////////////////////////
    @objc func deleteStatisticsButtonPushed() {
        do {
            let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            try managedObjectContext.save()
        } catch {
            // Error Handl
        }
        fetchingData()
        tableView.reloadData()
    }
////////////////////////////////////////////
// MARK: ALL FUNCTIONS
///////////////////////////////////////////
    func fetchingData() {
        resultArray = []
        resultStringArray = []
        for temp in temps{
            let result = FetchRequest.evaluate(tempsVerb: temp)
            resultArray.append(result)
            resultStringArray.append(result.3)
        }
    }
    func deleteStatisticButtonSetUp() {
        let yPosition = view.frame.height * 0.85
        let buttonWidth = view.frame.height * 0.1
        let xPosition = view.frame.width/2 - buttonWidth/2
        let buttonHeight = buttonWidth
        deleteStatisticsButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight))
        deleteStatisticsButton.layer.cornerRadius = deleteStatisticsButton.frame.height/2
        deleteStatisticsButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        deleteStatisticsButton.titleLabel?.textColor = UIColor.white
        let buttonName = """
        Delete
        Statistics
        """
        deleteStatisticsButton.titleLabel?.textAlignment = .center
        deleteStatisticsButton.titleLabel?.numberOfLines = 0
        deleteStatisticsButton.titleLabel?.lineBreakMode = .byWordWrapping
        deleteStatisticsButton.setTitle(buttonName, for: .normal)
        deleteStatisticsButton.titleLabel?.font = fonts.smallBoldFont
        self.navigationController?.view.addSubview(deleteStatisticsButton)
        deleteStatisticsButton.addTarget(self, action: #selector(deleteStatisticsButtonPushed), for: .touchUpInside)
    }

}
