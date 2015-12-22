//
//  GhostLoginToken.swift
//  Pods
//
//  Created by Kerr Marin Miller on 18/12/2015.
//
//


public struct GhostLoginToken {
    
    /**
     *  The access token used to authenticate with the Ghost installation.
     */
    public let accessToken : String
    
    /**
     *  the number of seconds after which this token will be invalid
     */
    public let expiry : Int
    
    /**
     *  Instantiates an instance of GhostLoginToken.
     *
     *  @param accessToken the access token that is to be used to authenticate with the Ghost installation
     *  @param expiry      the number of seconds after which this token will be invalid
     *
     *  @return a fully initialized GhostLoginToken
     */
    public init(token: String, expiry: Int) {
        self.accessToken = token
        self.expiry = expiry
    }
}