//
//  SLNetworkingTool.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import AFNetworking

enum SLNteworkingToolType:String {
    case GET = "get"
    case POST = "post"
}

class SLNetworkingTool: AFHTTPSessionManager {
    
    static let shared = { () -> SLNetworkingTool in
        
        let shared = SLNetworkingTool()
        
        shared.responseSerializer.acceptableContentTypes?.insert("text/html")
        shared.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return shared
    }()
    
    func requst(type: SLNteworkingToolType, URLString: String, parameters: Any?, success:@escaping (Any?)->(), failure:@escaping (Error)->()) -> () {
        
        if type == .GET {
            
            get(URLString, parameters: parameters, progress: nil, success: { (nil, Data) in
                
                success(Data)
                
            }, failure: { (nil, error) in
                
                failure(error)
                
            })
            
        } else {
            
            post(URLString, parameters: parameters, progress: nil, success: { (nil, Data) in
                
                success(Data)
                
            }, failure: { (nil, error) in
                
                failure(error)
            })
        }
    }
    
    func getQuery(success:@escaping (Any?)->(), failure:@escaping (Error)->()) -> () {
        
        let urlStr = API_QUERY_URL
        
        let parameters : [String : Any] = [
            "key": APIKEY,
        ]
        
        self.requst(type: .GET, URLString: urlStr, parameters: parameters, success: success, failure: failure)
    }
    
    func getList(success:@escaping (Any?)->(), failure:@escaping (Error)->()) -> () {
        
        let urlStr = API_LIST_URL
        
        let parameters : [String : Any] = [
            "key": APIKEY,
            ]
        
        self.requst(type: .GET, URLString: urlStr, parameters: parameters, success: success, failure: failure)
    }

    func getCurrency(from : String, to : String, success:@escaping (Any?)->(), failure:@escaping (Error)->()) -> () {
        
        let urlStr = API_CURRENCY_URL
        
        let parameters : [String : Any] = [
            "key"  : APIKEY,
            "from" : from,
            "to"   : to
            ]
        
        self.requst(type: .GET, URLString: urlStr, parameters: parameters, success: success, failure: failure)
    }
}
