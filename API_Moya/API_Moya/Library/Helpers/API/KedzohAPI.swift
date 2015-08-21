//
//  KedzohAPI.swift
//  API_Moya
//
//  Created by admin on 10.08.15.
//  Copyright (c) 2015 brocoders. All rights reserved.
//

import Foundation
import Moya

//MARK: - Provider setup

let KedzohProvider = MoyaProvider<Kedzoh>()

//MARK: - Provider support

private extension String {
    var URLEscapedStirng : String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public enum Kedzoh {
    case Login
}

extension Kedzoh : MoyaTarget {
    public var baseURL: NSURL { return NSURL(string: "http://kedzoh.com/api")! }
    public var path: String {
        switch self {
        case .Login:
            return "/login"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .Login:
            return .POST
        default:
            return .GET
        }
    }
    public var parameters: [String: AnyObject] {
        switch self {
        case .Login:
            return ["user" : ["email": "kedzoh1@kedzoh.com", "password": "kedzoh1234"] ]
        default :
            return [:]
        }
    }
    public var sampleData: NSData {
        switch self {
        case .Login:
            return "Test".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

public func url(route: MoyaTarget) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString!
}
