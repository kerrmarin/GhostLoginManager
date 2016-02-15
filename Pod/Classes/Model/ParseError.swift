//
//  Error.swift
//  Pods
//
//  Created by Kerr Marin Miller on 20/12/2015.
//
//

import Foundation

public let GhostLoginTokenParserParseError = "Error Parsing Token JSON"
public let GhostUserParserParseError = "Error Parsing User JSON"

internal let GhostErrorDomain = "com.ghostlogin.parsing"


public enum GhostParsingErrorCode : Int {
    case Unknown
    case UnexpectedTypes
    case InvalidJSON
}

internal enum ParseErrorType : ErrorType {
    case ParsingError(code: GhostParsingErrorCode, detail: String)
}