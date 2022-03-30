//
//  SchoolTableViewCell.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolInterest: UILabel!
    @IBOutlet weak var schoolCity: UILabel!

    @IBOutlet weak var detailsView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        /// Initialization code
        detailsView.cardView(radius: 5.0)
    }
    
    /// Configure the cell
    func configure(_ model: School) {
        self.schoolName.text = model.schoolName
        self.schoolInterest.text = model.interest
        self.schoolCity.text = model.city
    }
}
