//
//  IrregularVerbsTableViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-18.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class IrregularVerbsTableViewController: UITableViewController, UISearchBarDelegate {
    var irregularVerbs = [[String]]()
    let colorReference = ColorReference()
    let fonts = FontsAndConstraintsOptions()
    var searchActive : Bool = false
    var filtered:[String] = []
    var infiniveIrregular = [String]()
    var simplePast = [String]()
    var pastParticiple = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
         searchBar.delegate = self
        self.title = "Irregular Verbs List"
       
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/20
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/20))
        let infinitveLabel = UILabel()
        let simplePastLabel  = UILabel()
        let pastParticipleLabel = UILabel()
        let headerHeight = header.frame.height
        let headerWidth = header.frame.width
        let infiniveWidth = headerWidth/3
        infinitveLabel.frame = CGRect(x: 10, y: 0, width: infiniveWidth, height: headerHeight)
        simplePastLabel.frame = CGRect(x: infiniveWidth, y: 0, width: infiniveWidth, height: headerHeight)
        pastParticipleLabel.frame = CGRect(x: (2 * infiniveWidth) - 10, y: 0, width: infiniveWidth, height: headerHeight)
        header.backgroundColor = colorReference.specialGray
        infinitveLabel.text = "Infinitive"
        simplePastLabel.text = "Simple Past"
        pastParticipleLabel.text = "Past Participle"
        infinitveLabel.textColor = UIColor.white
        simplePastLabel.textColor = UIColor.white
        pastParticipleLabel.textColor = UIColor.white
        infinitveLabel.font = fonts.smallBoldFont
        simplePastLabel.font = fonts.smallBoldFont
        pastParticipleLabel.font = fonts.smallBoldFont
        header.addSubview(infinitveLabel)
        header.addSubview(simplePastLabel)
        header.addSubview(pastParticipleLabel)
        return header
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    //Filtering with search text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = infiniveIrregular.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        let searchHelper = SearcHelper(filtered: filtered, arrayVerbe: irregularVerbs)
        simplePast = searchHelper.simplePast
        pastParticiple = searchHelper.pastParticiple
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return infiniveIrregular.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IrregularVerbTableViewCell
        cell.infinitive.text = "to \(irregularVerbs[indexPath.row][0])"
        cell.simplePast.text = irregularVerbs[indexPath.row][1]
        cell.PastParticiple.text = irregularVerbs[indexPath.row][2]
        if searchActive {
            cell.infinitive.text = filtered[indexPath.row]
            cell.simplePast.text = simplePast[indexPath.row]
            cell.PastParticiple.text = pastParticiple[indexPath.row]
        }else{
            cell.infinitive.text = irregularVerbs[indexPath.row][0]
            cell.simplePast.text = irregularVerbs[indexPath.row][1]
            cell.PastParticiple.text = irregularVerbs[indexPath.row][2]
        }
        return cell
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
 

}
