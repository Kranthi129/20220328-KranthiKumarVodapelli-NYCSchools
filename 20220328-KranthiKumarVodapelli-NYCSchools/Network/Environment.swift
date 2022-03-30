//
//  Environment.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

/// enumaration for Environment
enum Environment {
    
    static let rootURLstring = "https://data.cityofnewyork.us"
    
    static let baseURL: URL = {
        guard let url = URL(string: rootURLstring) else {
          fatalError("Base URL is invalid")
        }
        return url
    }()
    
    static let schoolDirectoryURL: URL = {
        guard let url = URL(string: "\(rootURLstring)/resource/s3k6-pzi2.json") else {
          fatalError("School Directory URL is invalid")
        }
        return url
    }()
    
    static func getResultURL(dbn: String?) -> URL {
        
        guard let dbn = dbn, let url = URL(string: "\(rootURLstring)/resource/f9bf-2cp4.json?dbn=\(dbn)") else {
          fatalError("SAT Result URL is invalid")
        }
        return url
    }
}
