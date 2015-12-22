//
//  GhostLoginTokenJSONParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 18/12/2015.
//
//

import Foundation

public enum GhostLoginTokenErrorCode : Int {
    case Unknown
    case UnexpectedTypes
    case InvalidJSON
}


public struct GhostLoginTokenJSONParser: GhostLoginTokenParser {
    
    public func tokenFromResponse(response: AnyObject) throws -> GhostLoginToken? {
        guard let responseDictionary = response as? [String : AnyObject] else {
            throw Error.AccessTokenParsingError(domain: GhostLoginTokenParserParseError,
                code: GhostLoginTokenErrorCode.InvalidJSON.rawValue,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - JSON was not valid."])
        }
        
        guard let accessToken = responseDictionary["access_token"] as? String else {
            throw Error.AccessTokenParsingError(domain: GhostLoginTokenParserParseError,
                code: GhostLoginTokenErrorCode.UnexpectedTypes.rawValue,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - access_token was not a string"])
        }
        
        guard let expiryNumber = responseDictionary["expires_in"] as? NSNumber where expiryNumber.integerValue > 0 else {
            throw Error.AccessTokenParsingError(domain: GhostLoginTokenParserParseError,
                code: GhostLoginTokenErrorCode.UnexpectedTypes.rawValue,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - expires_in was either not a number or less than or equal to zero"])

        }
        
        let token = GhostLoginToken(token: accessToken, expiry: expiryNumber.integerValue)
        
        return token
    }
    
    public func refreshTokenFromResponse(response: AnyObject) throws -> String? {
        guard let responseDictionary = response as? [String : AnyObject] else {
            throw Error.RefreshTokenParsingError(domain: GhostLoginRefreshTokenParserParseError,
                code: GhostLoginTokenErrorCode.InvalidJSON.rawValue,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - JSON was not valid."])
        }
        
        guard let refreshToken = responseDictionary["refresh_token"] as? String else {
            throw Error.RefreshTokenParsingError(domain: GhostLoginRefreshTokenParserParseError,
                code: GhostLoginTokenErrorCode.UnexpectedTypes.rawValue,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - refresh_token was not a string"])
        }
        
        return refreshToken
        
    }
    
}