//
//  UIView+Extension.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

extension UIView {
    
    /// display card shape with corner radius and shadow
    /// - Parameter radius: CGFloat
    func cardView(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.brown.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}
