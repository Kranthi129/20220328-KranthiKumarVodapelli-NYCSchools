//
//  Utility.swift
//  20220328-KranthiKumarVodapelli-NYCSchools
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import UIKit

class Utility {
    /// Utility function to show alert
    /// - Parameters:
    ///   - title: String alert title
    ///   - message: String alert message
    ///   - contoller: UIViewController on which alert should be displayed
    static func alert(title: String, message: String, contoller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            contoller.present(alert, animated: true, completion: nil)
        }
    }

    /// Handling of open URLs  outside of application and errors while opening urls
    /// - Parameters:
    ///   - scheme: String scheme
    ///   - urlString: String url to be opened
    ///   - contoller: UIViewController on which alert should be displayed incase of error
    static func open(scheme: String, urlString: String?, contoller: UIViewController) {
        guard let urlString = urlString,
                let url = URL(string: "\(scheme)://\(urlString)"),
                UIApplication.shared.canOpenURL(url) else {
                    Utility.alert(title: "Error", message: "Unable to open url", contoller: contoller)
                    return
        }
        UIApplication.shared.open(url)
    }
}
