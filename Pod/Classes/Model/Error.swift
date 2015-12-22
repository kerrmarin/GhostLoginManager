//
//  Error.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//
//

import Foundation

enum Error : ErrorType {
    case AccessTokenParsingError(domain : String, code : Int, userInfo : [NSObject : AnyObject])
    case RefreshTokenParsingError(domain : String, code : Int, userInfo : [NSObject : AnyObject])
    
    var underlyingError : NSError {
        switch self {
        case .AccessTokenParsingError(let domain, let code, let userInfo):
            return NSError(domain: domain,
                             code: code,
                         userInfo: userInfo)
            
        case .RefreshTokenParsingError(let domain, let code, let userInfo):
            return NSError(domain: domain,
                             code: code,
                         userInfo: userInfo)
        }
    }
}