//
//  DetailsViewModel.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class DetailsViewModel: NSObject {
    
    /// Fetch Schools details from backend api
    /// - Parameters:
    ///   - networkManager: network manager instance
    ///   - school: School model object
    ///   - completionHandler: completion handler with optional scores and  optional error
    func getDetails(networkManager: NetworkManager = NetworkManager.instance,
                    school: School,
                    completionHandler: @escaping (([Scores]?, Error?) -> Void)) {
        
        networkManager.fetchData(url: Environment.getResultURL(dbn: school.dbn)) { (response: [Scores]?, error) in
            
            if (response?.first(where: { $0.dbn == school.dbn })) != nil {
                completionHandler(response, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }

}
