//
//  GhostLoginClient.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//

import Foundation

public typealias GhostLoginBlock = (token: GhostLoginToken?, error: NSError?) -> Void
public typealias GhostUserBlock = (user: GhostUser?, error: NSError?) -> Void

protocol GhostLoginClientDelegate {
    func loginClientTokenRefreshDidFail(client: GhostLoginClient, error: NSError)
}

public class GhostLoginClient {
    
    var delegate : GhostLoginClientDelegate?
    
    private(set) public var token : GhostLoginToken?
    
    private let manager : GhostLoginSessionManager
    private let parser : GhostLoginTokenParser
    private let userParser : GhostLoginUserParser
    
    private var refreshToken : String?
    private var timer : NSTimer?
    
    public init(manager: GhostLoginSessionManager, parser: GhostLoginTokenParser, userParser: GhostLoginUserParser) {
        self.manager = manager
        self.parser = parser
        self.userParser = userParser
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// Attempts to log in with a given username and password
    public func loginWithUsername(username: String, password: String, complete: GhostLoginBlock) {
        self.manager.loginWithUsername(username, password: password) { (results, error) -> Void in
            
            guard let results = results else {
                complete(token: nil, error: error)
                return
            }

            do {
                try self.extractTokensFromResponse(results)
            } catch ParseErrorType.ParsingError(let code, let detail) {
                let error = NSError(domain: GhostErrorDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey : detail])
                complete(token: nil, error: error)
                return
            } catch {
                let error = NSError(domain: GhostErrorDomain, code: -1000, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
                complete(token: nil, error: error)
                return
            }
            
            self.timer?.invalidate()
            self.refreshTimer()
            complete(token: self.token, error: nil)
        }
    }
    
    public func logout() {
        self.token = nil
        self.refreshToken = nil
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // Extracts the tokens from a response
    private func extractTokensFromResponse(results: AnyObject) throws {
        self.token = try self.parser.tokenFromResponse(results)
        self.refreshToken = try self.parser.refreshTokenFromResponse(results)
    }
    
    /// Refreshes the timer to fire just before the expected expiry given by the current token
    private func refreshTimer() {
        guard let token = self.token else {
            return
        }
        
        let interval = Double(token.expiry) * 0.9

        self.timer = NSTimer.scheduledTimerWithTimeInterval(interval,
            target: self,
            selector: "refreshAccessToken",
            userInfo: nil,
            repeats: false)
    }
    
    /// Attempts to refresh the access token with the current refresh token
    @objc private func refreshAccessToken() {
        guard self.refreshToken != nil else {
            return
        }
        self.manager.refreshTokenWithToken(self.refreshToken!) { (results, error) in
            guard let results = results else {
                self.delegate?.loginClientTokenRefreshDidFail(self, error: error!)
                return
            }
            
            do {
                self.token = try self.parser.tokenFromResponse(results)
                self.refreshTimer()
            } catch ParseErrorType.ParsingError(let code, let detail) {
                let error = NSError(domain: GhostErrorDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey : detail])
                self.delegate?.loginClientTokenRefreshDidFail(self, error: error)
                return
            } catch {
                let error = NSError(domain: GhostErrorDomain, code: -1000, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
                self.delegate?.loginClientTokenRefreshDidFail(self, error: error)
                return
            }
        }
    }
    
    //MARK: User
    public func getLoggedInUser(complete: GhostUserBlock) {
        guard let token = self.token?.accessToken else {
            return
        }
        
        self.manager.getCurrentlyLoggedInUser(token) { (results, error) in
            guard let results = results else {
                complete(user: nil, error: error)
                return
            }
            
            do {
                let users = try self.userParser.parseUsersFromResponse(results)
                complete(user: users!.first, error: nil)
            } catch ParseErrorType.ParsingError(let code, let detail) {
                let error = NSError(domain: GhostErrorDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey : detail])
                complete(user: nil, error: error)
            } catch {
                let error = NSError(domain: GhostErrorDomain, code: -1000, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
                complete(user: nil, error: error)
            }
        }
    }
}








