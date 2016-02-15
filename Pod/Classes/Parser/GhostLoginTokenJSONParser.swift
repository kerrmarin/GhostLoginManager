//
//  GhostLoginTokenJSONParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 18/12/2015.
//
//

import Foundation

public class GhostLoginTokenJSONParser: GhostLoginTokenParser {
    
    public init() {}

    public func tokenFromResponse(response: AnyObject) throws -> GhostLoginToken? {
        guard let responseDictionary = response as? [String : AnyObject] else {
            throw ParseErrorType.ParsingError(code: .InvalidJSON,
                detail: "Error Parsing JSON - JSON was not valid.")
        }
        
        guard let accessToken = responseDictionary["access_token"] as? String else {
            throw ParseErrorType.ParsingError(code: .UnexpectedTypes,
                detail: "Error Parsing JSON - access_token was not a string")
        }
        
        guard let expiryNumber = responseDictionary["expires_in"] as? NSNumber where expiryNumber.integerValue > 0 else {
            throw ParseErrorType.ParsingError(code: .UnexpectedTypes,
                detail: "Error Parsing JSON - expires_in was either not a number or less than or equal to zero")
        }
        
        let token = GhostLoginToken(accessToken: accessToken, expiry: expiryNumber.integerValue)
        
        return token
    }

    public func refreshTokenFromResponse(response: AnyObject) throws -> String? {
        guard let responseDictionary = response as? [String : AnyObject] else {
            throw ParseErrorType.ParsingError(code: .InvalidJSON,
                detail: "Error Parsing JSON - JSON was not valid.")
        }
        
        guard let refreshToken = responseDictionary["refresh_token"] as? String else {
            throw ParseErrorType.ParsingError(code: .UnexpectedTypes,
                detail: "Error Parsing JSON - refresh_token was not a string")
        }
        
        return refreshToken
    }
}