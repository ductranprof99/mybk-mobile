//
//  Constant.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation

struct Constant {
    static let SSO_MYBK_REDIRECT_URL =
    "https://sso.hcmut.edu.vn/cas/login?service=http%3A%2F%2Fmybk.hcmut.edu.vn%2Fstinfo%2F"
    static let SSO_URL =
    "https://sso.hcmut.edu.vn/cas/login"
    static let HTML_LOGIN_SUCCESS = "<h2>Log In Successful</h2>"
    static let HTML_WRONG_CREDENTIAL =
    "The credentials you provided cannot be determined to be authentic"
    static let STINFO_URL =
    "https://mybk.hcmut.edu.vn/stinfo/"
    static let SSO_MYBK_LOGOUT_URL = "https://sso.hcmut.edu.vn/cas/logout?service=http%3A%2F%2Fmybk.hcmut.edu.vn%2Fstinfo%2F"
    
    struct Key {
        static let username = "key.username"
        static let password = "key.password"
        static let name  = "key.name"
        static let faculty  = "key.faculty"
        static let isSaveData  = "key.saveData"
        static let mybkToken = "key.mybkToken"
        static let bioMetric = "key.bioInfomation"
    }
}

enum SSOState: String, Error {
    case UNAUTHORIZED
    case NO_CREDENTIALS
    case LOGGED_IN
    case WRONG_PASSWORD
    case TOO_MANY_TRIES
    case UNKNOWN
    case NETWORKERROR
}

enum MybkState {
    case LOGGED_IN
    case SSO_REQUIRED
    case UNKNOWN
}


