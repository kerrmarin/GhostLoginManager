//
//  GhostLoginUserJSONParser.swift
//  Pods
//
//  Created by Kerr Marin Miller on 24/01/2016.
//
//

import Foundation

public enum GhostLoginUserParsingErrorCode : Int {
    case UnexpectedTypes
}

public class GhostLoginUserJSONParser: GhostLoginUserParser {
    
    private let baseURL : String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
        
    public func parseUsersFromResponse(response: AnyObject) throws -> [GhostUser]? {
        guard let users = response["users"] as? [AnyObject] else {
            throw ParseErrorType.ParsingError(code: .UnexpectedTypes,
                detail: "Error Parsing JSON - response didn't have any users")
        }

        var ghostUsers : [GhostUser] = []
        for user in users {
            if let userId = user["id"] as? Int,
               let uuid = user["uuid"] as? String,
               let name = user["name"] as? String,
               let slug = user["slug"] as? String,
               let email = user["email"] as? String,
               let image = user["image"] as? String,
               let imageURL = NSURL(string: "\(self.baseURL)\(image)"),
               let cover = user["cover"] as? String,
               let coverURL = NSURL(string: "\(self.baseURL)\(cover)"),
               let bio = user["bio"] as? String,
               let website = user["website"] as? String,
               let websiteURL = NSURL(string: website),
               let location = user["location"] as? String,
               let status = user["status"] as? String,
               let language = user["language"] as? String {
                
                let userStatus : UserStatus = status == "active" ? .Active : .Unknown
                    let ghostUser = GhostUser(userId: userId, uuid: uuid, name: name, slug: slug, email: email, imageURL: imageURL, coverImageURL: coverURL, bio: bio, websiteURL: websiteURL, location: location, status: userStatus, language: language)
                    ghostUsers.append(ghostUser)
                
            } else {
                throw ParseErrorType.ParsingError(code: .UnexpectedTypes,
                    detail: "Error Parsing JSON - unexpected types in user object")
            }
        }
        return ghostUsers
    }
}
