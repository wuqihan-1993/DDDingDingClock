//
//  IMManager.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class IMManager: NSObject {
    
    static let appKey = "vnroth0kvbffo"
    static let appSecret = "U0UdpvK4kZq"
    
    static let `shared` = IMManager()
    
    var headers: HTTPHeaders {
        let nonce = String(Int64.random(in: 1000000000..<9999999999))
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let signature = (IMManager.appSecret + nonce + timestamp).sha1()
        let headers: HTTPHeaders = ["App-Key":IMManager.appKey,"Nonce":nonce,"Timestamp":timestamp,"Signature":signature]
        return headers
    }
    
    
    func getToken(userName:String, success:((JSON)->Void)?, failure:((Error)->Void)?) {
        
        let url = URL(string: "http://api-cn.ronghub.com/user/getToken.json")!
        let parameters: Parameters = ["userId":userName,"name":userName]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseSwiftyJSON { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                failure?(error)
            }
        }
        
    }
    
    func checkOnline(userId: String, success:((JSON)->Void)?, failure:((Error)->Void)?) {
        let url = URL(string: "http://api-cn.ronghub.com/user/checkOnline.json")!
        let parameters: Parameters = ["userId":userId];
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseSwiftyJSON { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}


