//
//  GhostLoginUserJSONParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 24/01/2016.
//
//

import Foundation

internal enum GhostLoginUserErrorCode : Int {
    case UnexpectedTypes
}

public struct GhostLoginUserJSONParser: GhostLoginUserParser {
    
    public init() {}
    
    public func parseUsersFromResponse(response: AnyObject) throws -> [GhostUser]? {
        guard let users = response["users"] as? [AnyObject] else {
            throw Error.AccessTokenParsingError(code: GhostLoginTokenErrorCode.UnexpectedTypes,
                userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - response didn't have any users"])
        }

        var ghostUsers : [GhostUser] = []
        for user in users {
            if let userId = user["id"] as? Int,
               let uuid = user["uuid"] as? String,
               let name = user["name"] as? String,
               let slug = user["slug"] as? String,
               let email = user["email"] as? String,
               let image = user["image"] as? String,
               let cover = user["cover"] as? String,
               let bio = user["bio"] as? String,
               let website = user["website"] as? String,
               let location = user["location"] as? String,
               let status = user["status"] as? String,
               let language = user["language"] as? String {
                
                    let userStatus = status == "Active" ? UserStatus.Active : UserStatus.Unknown
                    let ghostUser = GhostUser(userId: userId, uuid: uuid, name: name, slug: slug, email: email, image: image, cover: cover, bio: bio, website: website, location: location, status: userStatus, language: language)
                    ghostUsers.append(ghostUser)
                
            } else {
                throw Error.AccessTokenParsingError(code: GhostLoginTokenErrorCode.UnexpectedTypes,
                    userInfo: [NSLocalizedDescriptionKey : "Error Parsing JSON - unexpected types in user object"])
            }
        }
        return ghostUsers
    }
}