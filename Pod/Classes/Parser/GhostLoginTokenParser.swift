//
//  GhostLoginTokenParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 18/12/2015.
//
//

let GhostLoginTokenParserParseError = "Error Parsing JSON"
let GhostLoginRefreshTokenParserParseError = "Error Parsing Refresh Token JSON"

public protocol GhostLoginTokenParser {
    
    /**
     *  Takes a response from the session manager and parses it into a GhostLoginToken.
     *  This may return nil if the response is not valid.
     *
     *  @param response a response string, usually JSON or XML
     *  @param error    an error passed in to be populated if the parsing fails.
     *
     *  @return potentially, a GhostLoginToken containing the access token to use when
     *  authenticating against the Ghost installation.
     */
    func tokenFromResponse(response: AnyObject) throws -> GhostLoginToken?
    
    /**
     *  Takes a response from the session manager and parses it into a valid refresh token string.
     *
     *  @param response the response from the server. This usually comes in JSON or XML format.
     *  @param error    an error passed in to be populated if the parsing fails.
     *
     *  @return potentially, an NSString object containing the refresh token for this user.
     */
    func refreshTokenFromResponse(response: AnyObject) throws -> String?
    
}