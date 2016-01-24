//
//  GhostLoginClient.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//

import Foundation

public typealias GhostLoginBlock = (token: GhostLoginToken?, error: NSError?) -> Void

protocol GhostLoginClientDelegate {
    func loginClientTokenRefreshDidFail(client: GhostLoginClient, error: NSError)
}

public class GhostLoginClient {
    
    var delegate : GhostLoginClientDelegate?
    
    private(set) public var token : GhostLoginToken?
    
    private let manager : GhostLoginSessionManager
    private let parser : GhostLoginTokenParser
    
    private var refreshToken : String?
    private var timer : NSTimer?
    
    public init(manager: GhostLoginSessionManager, parser: GhostLoginTokenParser) {
        self.manager = manager
        self.parser = parser
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// Attempts to log in with a given username and password
    public func loginWithUsername(username: String, password: String, complete: GhostLoginBlock) {
        self.manager.loginWithUsername(username, password: password) { (results, error) -> Void in
            
            guard results != nil else {
                complete(token: nil, error: error)
                return;
            }

            do {
                try self.extractTokensFromResponse(results!)
            } catch let error {
                guard let e = error as? Error else {
                    let unknownError = NSError(domain: "Unknown error", code: Int.max, userInfo: nil)
                    complete(token: nil, error: unknownError)
                    return;
                }
                complete(token: nil, error: e.underlyingError)
                return;
            }
            
            self.timer?.invalidate()
            self.refreshTimer()
            complete(token: self.token, error: nil)
        }
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
        self.manager.refreshTokenWithToken(self.refreshToken!) { (results, error) -> Void in
            guard error == nil else {
                self.delegate?.loginClientTokenRefreshDidFail(self, error: error!)
                return
            }
            
            do {
                self.token = try self.parser.tokenFromResponse(results!)
                self.refreshTimer()
            } catch let error {
                guard let e = error as? Error else {
                    let unknownError = NSError(domain: "Unknown error", code: Int.max, userInfo: nil)
                    self.delegate?.loginClientTokenRefreshDidFail(self, error: unknownError)
                    return
                }
                self.delegate?.loginClientTokenRefreshDidFail(self, error: e.underlyingError)
            }
        }
    }
}








