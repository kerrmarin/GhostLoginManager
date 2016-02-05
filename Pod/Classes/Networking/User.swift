
//
//  File.swift
//  Pods
//
//  Created by Kerr Marin Miller on 27/01/2016.
//
//

import Foundation
import Alamofire

enum User : URLRequestConvertible {
    
    case Get(baseUrl : String, token: String)
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: String]) = {
            switch self {
            case .Get(let baseUrl, let token):
                let parameters = ["access_token" : token]
                return (baseUrl + "/users/me", parameters)
            }
        }()
        
        let URL = NSURL(string: result.path)!
        let URLRequest = NSMutableURLRequest(URL: URL)
        URLRequest.HTTPMethod = "GET"
        URLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}

