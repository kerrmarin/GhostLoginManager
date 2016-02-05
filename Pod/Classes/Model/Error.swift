//
//  Error.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//
//

import Foundation

private let GhostLoginTokenParserParseError = "Error Parsing Token JSON"
private let GhostUserParserParseError = "Error Parsing User JSON"

internal enum Error : ErrorType {
    case AccessTokenParsingError(code : GhostLoginTokenErrorCode, userInfo : [NSObject : AnyObject])
    case RefreshTokenParsingError(code : GhostLoginTokenErrorCode, userInfo : [NSObject : AnyObject])
    case UserParsingError(code : GhostLoginUserErrorCode, userInfo : [NSObject : AnyObject])
    
    internal var underlyingError : NSError {
        switch self {
        case .AccessTokenParsingError(let code, let userInfo):
            return NSError(domain: GhostLoginTokenParserParseError,
                             code: code.rawValue,
                         userInfo: userInfo)
            
        case .RefreshTokenParsingError(let code, let userInfo):
            return NSError(domain: GhostLoginTokenParserParseError,
                             code: code.rawValue,
                         userInfo: userInfo)
            
        case .UserParsingError(let code, let userInfo):
            return NSError(domain: GhostUserParserParseError,
                             code: code.rawValue,
                         userInfo: userInfo)
        }
    }
}