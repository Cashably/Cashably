//
//  RequestHandler.swift
//  Cashably
//
//  Created by apollo on 7/28/22.
//

import Foundation
import Alamofire

class RequestHandler {
    static let sharedInstance = RequestHandler()
        
    class func loginUser(email: String = "", password: String = "", phone: String = "", success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.LOGIN
        
        let param : [String : Any] = [
            "email" : email,
            "pwd": password,
            "phone": phone
        ]
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param, isAuth: false, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status == true {
                if let userData = dictionary["data"] as? [String:Any] {
//                    let accessToken = userData["token"] as! String
//                    Shared.storeUserToken(token: accessToken)
                    Shared.storeUser(user: userData)
//                    Shared.completeUserProfile(status: userData["isCompletedProfile"] as! Bool)
                }
                
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
            
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: "Network error!"))
        }
    }

    class func registerUser(email: String = "", password: String = "", phone: String = "", success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.SIGNUP
        
        let param : [String : Any] = [
            "email" : email,
            "pwd": password,
            "phone": phone
        ]
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param, isAuth:false, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                let user = dictionary["user"] as! [String: Any]
                let accessToken = user["token"] as! String
                Shared.storeUserToken(token: accessToken)
                Shared.storeUser(user: user)
                Shared.completeUserProfile(status: false)
                
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
            
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }
    
    class func checkPhone(phone: String, type: String = "login", success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        var url = ""
        if type == "login" {
            url = Constants.URL.LOGIN_PHONE_CHECK
        } else {
            url = Constants.URL.SIGNUP_PHONE_CHECK
        }
        
        let param : [String: Any] = [
            "phone": phone
        ]
        
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param, isAuth:false, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
            
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }

    class func forgotPassword(email: String, success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.FORGOT_PASSWORD
        print(url)
        
        let param : [String: Any] = [
            "email": email
        ]
        NetworkHandler.postRequest(url: url, parameters: param, isAuth:false, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                Shared.storeForgotToken(token: dictionary["token"] as! String)
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }

    class func resetPassword(otp: String, password: String, success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.RESET_PASSWORD
        print(url)
        let param : [String: Any] = [
            "pwd": password,
            "otp": otp,
            "token": Shared.getForgotToken()
        ]
        NetworkHandler.postRequest(url: url, parameters: param, isAuth:false, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }

    class func profileUpdate(parameter: NSDictionary, success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.UPDATE_USER_PROFILE
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, isAuth:true, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                if var userData = dictionary["data"] as? [String:Any] {
                    let user = Shared.getUser()
                    userData["token"] = user.token
                    userData["isCompletedProfile"] = user.isCompletedProfile
                    Shared.storeUser(user: userData)
                }
                
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
            
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }

    class func getRequest(url: String, parameter: NSDictionary, success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        print(url)
        NetworkHandler.getRequest(url: url, parameters: parameter as? Parameters, isAuth:true, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }
    
    class func postRequest(url: String, parameter: NSDictionary, success: @escaping(Any?)-> Void, failure: @escaping(NetworkError)-> Void) {
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, isAuth:true, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let status = dictionary["status"] as! Bool
            if status {
                success(successResponse)
            } else {
                failure(NetworkError(status: Constants.NetworkError.generic, message: dictionary["message"] as! String))
            }
        }) { (error) in
            print(error.message)
            failure(NetworkError(status: Constants.NetworkError.serverErrorCode, message: error.message))
        }
    }
}
