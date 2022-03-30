//
//  ListViewModel.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class ListViewModel: NSObject {

    var schools: [School]? = [School]()
    var filteredSchools: [School]? = [School]()
    
    /// Fetch schools list from backend api
    /// - Parameters:
    ///   - networkManager: network manager object
    ///   - completionHandler: completion handler to be passed which contain optional error
    func fetchSchoolsData(networkManager: NetworkManager = NetworkManager.instance,
    completionHandler: @escaping (Error?) -> Void) {
        
        networkManager.fetchData(url: Environment.schoolDirectoryURL) { [weak self] (response: [School]?, error) in
            
            self?.schools = response
            self?.filteredSchools = self?.schools?.sorted(by: { school1, school2 in
                var status = false
                if let name1 = school1.schoolName, let name2 = school2.schoolName {
                    status = name1 < name2
                }
                return status
            })
            completionHandler(error)
        }
    }
    
    /// Filter school list with given search text
    /// - Parameter searchText: String
    ///  filter the schools list with given string
    func filterSchools(searchText: String) {
        filteredSchools = searchText.isEmpty ? schools : schools?.filter({ (school: School) -> Bool in
            return school.schoolName?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })

    }

}
