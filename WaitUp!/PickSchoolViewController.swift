//
//  PickSchoolViewController.swift
//  WaitUp!
//
//  Created by Max Zuo on 10/8/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit

protocol PickSchoolViewControllerDelegate {
    func setSchool()
}

class PickSchoolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: ViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var filteredSchools = [String]()
    var schools: Array<String>!
    var selectedSchool: String? = nil
    
    @IBOutlet var schoolTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if delegate!.schools != nil {
            schools = delegate!.schools
        }
        else {
            schools = [""]
        }
        
        schoolTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        schoolTableView.tableHeaderView = searchController.searchBar

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSchools = schools.filter { school in
            return school.lowercased().contains(searchText.lowercased())
        }
        
        schoolTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if searchController.isActive && searchController.searchBar.text != "" && indexPath.row < filteredSchools.count {
            cell.textLabel!.text = filteredSchools[indexPath.row]
        }
        else if searchController.isActive == false || searchController.searchBar.text == ""{
            cell.textLabel!.text = schools[indexPath.row]
        }
        else {
            cell.textLabel!.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var name = ""
        if searchController.isActive && searchController.searchBar.text != "" {
            name = filteredSchools[indexPath.row]
        }
        else {
            name = schools[indexPath.row]
        }
        
        if name != "" {
            selectedSchool = name
            delegate!.schoolLabel.text = selectedSchool!
            self.dismiss(animated: true, completion: nil)
//            performSegue(withIdentifier: "SelectSchool", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        delegate!.selectedSchool = selectedSchool!
        delegate!.schoolLabel.text = selectedSchool!
    }

}

extension PickSchoolViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
