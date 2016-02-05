//
//  Login.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//
//

import Foundation
import Alamofire

enum Token : URLRequestConvertible {
    
    case Get(baseUrl : String, username: String, password: String)
    case Refresh(baseUrl : String, token: String)
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: String]) = {
            switch self {
            case .Get(let baseUrl, let username, let password):
                let parameters = ["grant_type" : "password",
                                  "username" : username,
                                  "password" : password,
                                  "client_id" : "ghost-admin"]
                
                return (baseUrl + "/authentication/token", parameters)
                
            case .Refresh(let baseUrl, let token):
                let parameters = ["grant_type" : "refresh_token",
                                  "refresh_token" : token,
                                  "client_id" : "ghost-admin"]
                
                return (baseUrl + "/authentication/token", parameters)
            }
        }()
        
        let URL = NSURL(string: result.path)!
        let URLRequest = NSMutableURLRequest(URL: URL)
        URLRequest.HTTPMethod = "POST"
        URLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}

