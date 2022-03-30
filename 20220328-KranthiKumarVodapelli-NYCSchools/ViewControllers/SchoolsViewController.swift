//
//  SchoolsViewController.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class SchoolsViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataAvailable: UILabel!

    var selectedSchool: School?
    let spinner = UIActivityIndicatorView(style: .large)

    lazy var listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// set searchbar delegate
        searchBar.delegate = self
        spinner.color = .systemBackground
        addRefreshControl()
        getSchoolsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "NYC Schools"
    }
    
    // MARK: - Private functions
    
    //add pull to refresh view
   private func addRefreshControl() {
       refreshControl = UIRefreshControl()
        if let refreshControl = refreshControl {
            refreshControl.tintColor = .systemBackground
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemBackground])
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl)
        }
    }
    
    /// Fetch schools list from view model which will hit the api and convert them to models
    func getSchoolsData() {
        
        showActivityIndicator()
        listViewModel.fetchSchoolsData { [weak self] error in
            guard let strongSelf = self else {
                return
            }
            defer {
                strongSelf.hideActivityIndicator()
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
            if let error = error {
                Utility.alert(title: "Error", message: error.localizedDescription, contoller: strongSelf)
            }
        }
    }

    /// show activity indicator on main queue
    private func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.startAnimating()
            self?.tableView.backgroundView = self?.spinner
            self?.noDataAvailable.isHidden = true

        }
    }
    
    /// hide activity indicator on main queue
    private func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            self?.spinner.hidesWhenStopped = true
            self?.refreshControl?.endRefreshing()
        }
    }
    /// refresh school data
    @objc func refresh(_ sender: AnyObject) {
        getSchoolsData()
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == "schoolDetailIdentifier" {
            guard let schoolDetailViewController = segue.destination as? SchoolDetailsViewController else {
                return
            }
            schoolDetailViewController.school = selectedSchool
        }
    }
}

// searchbar delegate
extension SchoolsViewController: UISearchBarDelegate {
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        listViewModel.filterSchools(searchText: searchText)
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            listViewModel.filterSchools(searchText: text)
        } else {
            listViewModel.filterSchools(searchText: "")
        }
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension SchoolsViewController {
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        noDataAvailable.isHidden = (listViewModel.filteredSchools?.count != 0)
        return listViewModel.filteredSchools?.count ?? 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCellId") as? SchoolTableViewCell {
            if let school = listViewModel.filteredSchools?[indexPath.row] {
                cell.configure(school)
            }
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedSchool = listViewModel.filteredSchools?[indexPath.row]
        return indexPath
    }

}
