//
//  GhostLoginUserParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 24/01/2016.
//
//

import Foundation

public protocol GhostLoginUserParser {
    
    /*
    Parses a set of users from a given response
    */
    func parseUsersFromResponse(response: AnyObject) throws -> [GhostUser]?
    
}