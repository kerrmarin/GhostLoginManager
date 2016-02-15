//
//  User.swift
//  Pods
//
//  Created by Kerr Marin Miller on 24/01/2016.
//
//

import Foundation

public enum UserStatus : String {
    case Active
    case Unknown
}

public struct GhostUser {
    public let userId : Int
    public let uuid : String
    public let name : String
    public let slug : String
    public let email : String
    public let imageURL : NSURL
    public let coverImageURL : NSURL
    public let bio : String
    public let websiteURL : NSURL
    public let location : String
    public let status : UserStatus
    public let language : String
}
