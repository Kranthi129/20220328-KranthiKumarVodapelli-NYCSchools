//
//  SchoolDetailsViewController.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit
import MapKit

class SchoolDetailsViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!

    var score: Scores?
    var school: School?
    //View model object
    lazy var detailViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = school?.schoolName
        updateUI()
    }
    
    // MARK: - Private functions
    /// Update map and score
    private func updateUI() {
        fetchScores()
        displayMap()
    }

    /// It will fetch scores from view model and display them in tableview.
    private func fetchScores() {
        
        if let school = school {
            detailViewModel.getDetails(school: school) { [weak self] (response: [Scores]?, error) in
                
                if response == nil {
                    return
                }
                if let score = response?.first(where: { $0.dbn == self?.school?.dbn }) {
                    self?.score = score
                }
                DispatchQueue.main.async {
                    self?.detailTableView.reloadData()
                }
            }
        }
    }
    
    /// display map with location details
    private func displayMap() {
        
        guard let latitude = Double(school?.latitude ?? "0"), let longitude = Double(school?.longitude ?? "0") else {
            return
        }

        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.school?.schoolName
        mapView.addAnnotation(annotation)
    }
}

extension SchoolDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifiers = ["detailViewId", "scoresViewId", "contactViewId"]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row]) as? SchoolDetailsCell {
            cell.delegate = self
            switch indexPath.row {
            case 1:
                cell.updateScores(score: score)
            case 2:
                cell.updateContactInfo(school: school)
            default:
                cell.updateStudents(school: school, score: score)
            }
            return cell
        }

        return UITableViewCell()
    }
}

extension SchoolDetailsViewController: SchoolDetailsDelegate {
    // MARK: - SchoolDetailsDelegate
    func handleUrl(scheme: String, url: String?) {
        Utility.open(scheme: scheme, urlString: url, contoller: self)
    }
}
