//
//  NYCNavigationController.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class NYCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Set Navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
    
        appearance.backgroundColor = UIColor(red: 62.0/255, green: 112.0/255, blue: 184.0/255, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        }

    }
}
