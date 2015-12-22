//
//  GhostLoginSessionManager.swift
//  Pods
//
//  Created by Kerr Marin Miller on 18/12/2015.
//
//

import Foundation

public typealias GhostLoginNetworkBlock = (results : AnyObject?, error: NSError?) -> Void

public protocol GhostLoginSessionManager {
    /**
     *  Performs the network request to login in with a given username and password. When the
     *  request returns, calls the completion block with a set of results and an error, both optional.
     *
     *  @param username the uername to log in with. This is the user's email address.
     *  @param password the password to use to authenticate along with the username.
     *  @param complete a block to call with the results of the network call.
     *
     */
    func loginWithUsername(username: String, password: String, complete: GhostLoginNetworkBlock)
    
    /**
    *  Refreshes the access token with a given refresh token. This ensures that the user doesn't have
    *  to continuously log in, and there shouldn't be any reason to store their username and password
    *  locally, just store the refresh token.
    *
    *  @param token    a random string that is used to refresh the access token.
    *  @param complete a block called with the results of the network request.
    *
    */
    func refreshTokenWithToken(token: String, complete: GhostLoginNetworkBlock)
}