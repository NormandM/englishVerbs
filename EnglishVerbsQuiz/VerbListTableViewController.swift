//
//  VerbListTableViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-18.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class VerbListTableViewController: UITableViewController {
    var verbArray: NSArray = []
    var verbsArray:[[String]] = []
    var verbInfinitive: [String] = []
    var searchActive : Bool = false
    var filtered:[String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Choose Verb"
        verbsArray = verbArray as! [[String]]
       for verbs in verbsArray {
           verbInfinitive.append(verbs[0])
        }
        func alpha (_ s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        verbInfinitive = verbInfinitive.sorted(by: alpha)
        
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
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
        filtered = verbInfinitive.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }

        return verbInfinitive.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searchActive){
            cell.textLabel?.text = filtered[(indexPath as NSIndexPath).row]
        } else {
            cell.textLabel!.text = verbInfinitive[(indexPath as NSIndexPath).row]
        }
        return cell
    }
    // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showTense"{
                let controller = segue.destination as! ListeVerbTenseTableViewController
                    if let indexPath = self.tableView.indexPathForSelectedRow, let verbeChoisi = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                        let backItem = UIBarButtonItem()
                        backItem.title = ""
                        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                        controller.verbeInfinitif = verbeChoisi
                        controller.verbArray = verbArray

                }
            }
    }
}
