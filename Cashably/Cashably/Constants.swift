//
//  Constatns.swift
//  Cashably
//
//  Created by apollo on 7/8/22.
//

import Foundation

class Constants {
    struct URL {
        static let API = "https://app.cashably.com/api"
        static let USER_API = API + "/user"
        static let LOGIN = API + "/login"
        static let LOGIN_PHONE_CHECK = API + "/login/phone/check"
        static let SIGNUP = API + "/signup"
        static let SIGNUP_PHONE_CHECK = API + "/signup/phone/check"
        static let FORGOT_PASSWORD = API + "/forgot_password"
        static let RESET_PASSWORD = API + "/reset_password"
        
        static let GET_USER_PROFILE = USER_API + "/profile"
        static let UPDATE_USER_PROFILE = USER_API + "/profile/update"
        static let GET_PLAID_USER_TOKEN = USER_API + "/plaid/user_token"
        static let GET_PLAID_LINK_TOKEN = USER_API + "/plaid/link_token"
        static let PLAID_EXCHANGE_PUB_TOKEN = USER_API + "/plaid/exchange_public_token"
        static let LOAN_CHECK = USER_API + "/loan/check"
        static let LOAN_REQUEST = USER_API + "/loan/request"
        static let LOAN_ACCEPT = USER_API + "/loan/accept"
        static let WITHDRAW = USER_API + "/withdraw"
        static let REPAY = USER_API + "/repay"
        static let SNOOZE_PAY = USER_API + "/snooze_pay"
        static let GET_TRANSACTIONS = USER_API + "/transactions"
    }
    
    struct NetworkError {
            static let timeOutInterval: TimeInterval = 20
            
            static let error = "Error"
            static let internetNotAvailable = "Internet Not Available"
            static let pleaseTryAgain = "Please Try Again"
            
            static let generic = 400
            static let genericError = "Please Try Again."
            
            static let serverErrorCode = 500
            static let serverNotAvailable = "Server Not Available"
            static let serverError = "Server Not Availabe, Please Try Later."
            
            static let timout = 401
            static let timoutError = "Network Time Out, Please Try Again."
            
            static let login = 403
            static let loginMessage = "Unable To Login"
            static let loginError = "Please Try Again."
            
            static let internet = 404
            static let internetError = "Internet Not Available"
        }
        
        struct NetworkSuccess {
            static let statusOK = 200
        }
}
