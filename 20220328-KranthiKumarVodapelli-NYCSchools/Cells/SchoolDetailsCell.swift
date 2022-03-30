//
//  SchoolDetailsCell.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

protocol SchoolDetailsDelegate: AnyObject {
    func handleUrl(scheme: String, url: String?)
}

class SchoolDetailsCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var totalTestTakers: UILabel!
    @IBOutlet weak var totalStudentsLabel: UILabel!

    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var websiteImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var mapImage: UIImageView!
    
    weak var delegate: SchoolDetailsDelegate?
    
    var school: School?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.cardView(radius: 10.0)
    }
    
    
    /// Updated Labels with Students information
    /// - Parameters:
    ///   - school: school model
    ///   - score: score model
    func updateStudents(school: School?, score: Scores?) {
        self.school = school
        totalStudentsLabel.text = school?.totalStudents
        totalTestTakers.text = score?.totalTestTakers ?? "N/A"

    }
    
    /// Updated Scores label with Score information
    /// - Parameters:
    ///   - score: score model
    func updateScores(score: Scores?) {
        if let score = score {
            mathLabel.text = score.math
            readingLabel.text = score.reading
            writingLabel.text = score.writing
        }
    }
    
    /// Updated details label with School information
    /// - Parameters:
    ///   - school: school model
    func updateContactInfo(school: School?) {
        self.school = school
        if let name = school?.schoolName, let location = school?.location {
            locationLabel.text = name + "\n" + location
        }
        navigateToEmail()
        navigateToMaps()
        callPhone()
        navigateToWebsite()
    }
    
    // MARK: - Actions -
    private func navigateToEmail() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openEmail(_:)))
        emailImage.isUserInteractionEnabled = true
        emailImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openEmail(_ sender: AnyObject) {
        delegate?.handleUrl(scheme: "mailto", url: "mailto:\(self.school?.email ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }
    
    private func navigateToWebsite() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openWebsite(_:)))
        websiteImage.isUserInteractionEnabled = true
        websiteImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openWebsite(_ sender: AnyObject) {
        delegate?.handleUrl(scheme: "https", url: self.school?.website)
    }
    
    private func callPhone() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dialPhone(_:)))
        phoneImage.isUserInteractionEnabled = true
        phoneImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dialPhone(_ sender: AnyObject) {
        delegate?.handleUrl(scheme: "telprompt", url: self.school?.phone)
    }
    
    private func navigateToMaps() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap(_:)))
        mapImage.isUserInteractionEnabled = true
        mapImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func showMap(_ sender: AnyObject) {
        if let lattitude = school?.latitude, let longtitude = school?.longitude {
            let address = "maps.google.com/maps?ll=\(lattitude),\(longtitude)"
            delegate?.handleUrl(scheme: "https", url: address)
        }
    }

}
