//
//  NetworkHandler.swift
//  Cashably
//
//  Created by apollo on 7/28/22.
//

import Foundation
import Alamofire

class NetworkHandler {

    class func postRequest(url: String, parameters: Parameters?, isAuth: Bool, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
       
        if Network.isAvailable {
            var headers: HTTPHeaders
            if isAuth {
                
                let userAuthToken = Shared.getUserToken()
                
                headers = [
                "Accept": "application/json",
                "Authorization": "\(userAuthToken)"
                ]
            } else {
                
                headers = [
                    "Accept": "application/json"
                    ]
            }
//            print(headers)
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
            print(parameters)
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON
                { (response) -> Void in
                    
                print("response \(response)")
                
 
                    guard let statusCode = response.response?.statusCode else {
                        var networkError = NetworkError()
                        
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        
                        failure(networkError)
                        return
                        
                    }
                
                    if statusCode != 200 {
                        
                        var networkError = NetworkError()
                        
                        let response = response.value!
                        
                        if response is String {
                            networkError.status = statusCode
                            networkError.message = response as! String
                            
                            failure(networkError)
                            
                            return
                        }
                        
                        let dictionary = response as! [String: AnyObject]
                        guard let message = dictionary["error"] as? String else {
                            networkError.status = statusCode
                            networkError.message = "Validation Error"
                            
                            failure(networkError)
                            
                            return
                        }
                        networkError.status = statusCode
                        networkError.message = message
                        
                        failure(networkError)
                        
                        
                    }else{
                        
                        switch (response.result) {
                        case .success:
                            let response = response.value!
                            
                            success(response)
                            break
                        case .failure(let error):
                            var networkError = NetworkError()
                            
                            if error._code == NSURLErrorTimedOut {
                                networkError.status = Constants.NetworkError.timout
                                networkError.message = Constants.NetworkError.timoutError
                                
                                failure(networkError)
                            } else {
                                networkError.status = Constants.NetworkError.generic
                                networkError.message = Constants.NetworkError.genericError
                                
                                failure(networkError)
                            }
                            break
                        }
                    }
                }
        } else {
            let networkError = NetworkError(status: Constants.NetworkError.internet, message: Constants.NetworkError.internetError)
            failure(networkError)
        }
    }
    
    class func getRequest(url: String, parameters: Parameters?, isAuth: Bool, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
        
       var headers: HTTPHeaders
        if isAuth {
            let userAuthToken = Shared.getUserToken()
            print(userAuthToken)
            headers = [
                "Accept": "application/json",
                "Authorization": "\(userAuthToken)",
                ]
            } else {

                headers = [
                    "Accept": "application/json",
                    ]
            }
        
        manager.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) -> Void in
      
            debugPrint(response)
//            print(response)
            guard let statusCode = response.response?.statusCode else {
                var networkError = NetworkError()
                
                networkError.status = Constants.NetworkError.timout
                networkError.message = Constants.NetworkError.timoutError
                
                failure(networkError)
                return
                
            }
        
            if statusCode != 200 {
                var networkError = NetworkError()
                
                let response = response.value!
                if response is String {
                    networkError.status = statusCode
                    networkError.message = response as! String
                    
                    failure(networkError)
                    
                    return
                }
                
                let dictionary = response as! [String: AnyObject]
                guard let message = dictionary["error"] as? String else {
                    networkError.status = statusCode
                    networkError.message = "Validation Error"
                    
                    failure(networkError)
                    
                    return
                }
                networkError.status = statusCode
                networkError.message = message
                
                failure(networkError)
                
                
            }
            else {
                switch response.result{
                //Case 1
                case .success:
                    let response = response.value
                    success(response)
                    break
                case .failure (let error):
                    var networkError = NetworkError()
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        
                        failure(networkError)
                    } else {
                        networkError.status = Constants.NetworkError.generic
                        networkError.message = Constants.NetworkError.genericError
                        
                        failure(networkError)
                    }
                    break
                }
            }
        }
    }
    
    class func deleteRequest(url: String, parameters: Parameters?, isAuth: Bool, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
            
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
            
        var headers: HTTPHeaders
            if isAuth {
                let userAuthToken = Shared.getUserToken()
                headers = [
                    "Accept": "application/json",
                    "Authorization": "\(userAuthToken)",
                    ]
                } else {

                    headers = [
                        "Accept": "application/json",
                        ]
                }
            
        manager.request(url, method: .delete, parameters: parameters, headers: headers).responseJSON { (response) -> Void in
    
            debugPrint(response)
    //            print(response)
            guard let statusCode = response.response?.statusCode else {
                var networkError = NetworkError()
                
                networkError.status = Constants.NetworkError.timout
                networkError.message = Constants.NetworkError.timoutError
                
                failure(networkError)
                return
                
            }
        
            if statusCode != 200 {
                var networkError = NetworkError()
                
                let response = response.value!
                if response is String {
                    networkError.status = statusCode
                    networkError.message = response as! String
                    
                    failure(networkError)
                    
                    return
                }
                
                let dictionary = response as! [String: AnyObject]
                guard let message = dictionary["error"] as? String else {
                    networkError.status = statusCode
                    networkError.message = "Validation Error"
                    
                    failure(networkError)
                    
                    return
                }
                networkError.status = statusCode
                networkError.message = message
                
                failure(networkError)
                
                
            }
            else {
                switch response.result{
                //Case 1
                case .success:
                    let response = response.value
                    success(response)
                    break
                case .failure (let error):
                    var networkError = NetworkError()
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        
                        failure(networkError)
                    } else {
                        networkError.status = Constants.NetworkError.generic
                        networkError.message = Constants.NetworkError.genericError
                        
                        failure(networkError)
                    }
                    break
                }
            }
        }
    }
    
    class func upload(url: String, fileData: Data, fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        var headers: HTTPHeaders
        let userAuthToken = Shared.getUserToken()
        
        headers = [
        "Accept": "application/json",
        "Authorization": "\(userAuthToken)"
        ]
        
        AF.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(fileData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
            if let parameters = params {
                for (key, value) in parameters {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
            .uploadProgress { progress in
                    
                let progress = Int(progress.fractionCompleted * 100)
                uploadProgress(progress)
            }
            .responseJSON { res in
                switch res.result {
                case .success(let upload):
                    
                    break
                case .failure(let error):
                    print("upload error: " + error.localizedDescription)
                    var networkError = NetworkError()
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        failure(networkError)
                    } else {
                        networkError.status = Constants.NetworkError.generic
                        networkError.message = Constants.NetworkError.genericError
                        failure(networkError)
                    }
                }
            }
        
    }
}




struct NetworkError {
    var status: Int = Constants.NetworkError.generic
    var message: String = Constants.NetworkError.genericError
}

struct NetworkSuccess {
    var status: Int = Constants.NetworkError.generic
    var message: String = Constants.NetworkError.genericError
}
