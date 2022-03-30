//
//  School.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import Foundation

/// Decodable School Model
struct School: Decodable {
    
    var dbn: String?
    var schoolName: String?
    var overviewParagraph: String?
    var latitude: String?
    var longitude: String?
    var totalStudents: String?
    var location: String?
    var phone: String?
    var email: String?
    var website: String?
    var city: String
    var interest: String
    
    enum CodingKeys: String, CodingKey {
        case dbn, latitude, longitude, location, website, city
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case totalStudents = "total_students"
        case phone = "phone_number"
        case email = "school_email"
        case interest = "interest1"
    }

}
