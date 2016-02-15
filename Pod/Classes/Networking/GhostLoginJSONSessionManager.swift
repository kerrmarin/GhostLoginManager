//
//  GhostLoginJSONSessionManager.swift
//  Pods
//
//  Created by Kerr Marin Miller on 19/12/2015.
//
//

import Foundation
import Alamofire

public struct GhostLoginJSONSessionManager : GhostLoginSessionManager {
    
    private let baseURL : NSURL
    private let path = "/ghost/api/v0.1"
    
    /**
     *  Initializes this object with a given domain URL. This is the base domain for the
     *  ghost installation. For example:
     *
     *  - https://blog.example.com
     *  - http://example.com
     *  - http://example.com/blog
     *
     *  @param domainURL the URL where the Ghost installation is hosted
     *
     */
    public init(domainURL: NSURL) {
        self.baseURL = domainURL
    }
    
    public func loginWithUsername(username: String, password: String, complete: GhostLoginNetworkBlock) {
        let urlString = self.baseURL.absoluteString.stringByAppendingString(self.path)
        
        Alamofire.request(Token.Get(baseUrl: urlString, username: username, password: password)).responseJSON { response in
            if let JSON = response.result.value {
                complete(results: JSON, error: nil)
            } else {
                complete(results: nil, error: response.result.error)
            }
        }
    }
    
    public func refreshTokenWithToken(token: String, complete: GhostLoginNetworkBlock) {
        let urlString = self.baseURL.absoluteString.stringByAppendingString(self.path)
        
        Alamofire.request(Token.Refresh(baseUrl: urlString, token: token)).responseJSON { response in
            if let JSON = response.result.value {
                complete(results: JSON, error: nil)
            } else {
                complete(results: nil, error: response.result.error)
            }
        }
    }
    
    public func getCurrentlyLoggedInUser(token: String, complete: GhostLoginNetworkBlock) {
        let urlString = self.baseURL.absoluteString.stringByAppendingString(self.path)
        
        Alamofire.request(User.Get(baseUrl: urlString, token: token)).responseJSON { response in
            if let JSON = response.result.value {
                complete(results: JSON, error: nil)
            } else {
                complete(results: nil, error: response.result.error)
            }
        }
    }
}


