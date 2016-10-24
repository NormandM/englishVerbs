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
    var verbsArray: NSArray = []
    var verbInfinitive: [String] = []
    var searchActive : Bool = false
    var filtered:[String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Choose Verb"
        verbsArray = verbArray
       for verbs in verbsArray {
           verbInfinitive.append(verbs[0] as! String)
        }
        func alpha (s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        verbInfinitive = verbInfinitive.sort(alpha)
        
        
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    //Filtering with search text
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = verbInfinitive.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }

        return verbInfinitive.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel!.text = verbInfinitive[indexPath.row]
        }
        return cell
    }
    // MARK: - Navigation

        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "showTense"{
                let controller = segue.destinationViewController as! ListeVerbTenseTableViewController
                    if let indexPath = self.tableView.indexPathForSelectedRow, let verbeChoisi = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text {
                        let backItem = UIBarButtonItem()
                        backItem.title = ""
                        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                        controller.verbeInfinitif = verbeChoisi
                        controller.verbArray = verbArray

                }
            }
    }
}
