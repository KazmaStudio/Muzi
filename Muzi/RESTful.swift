//
//  RESTful.swift
//  Muzi
//
//  Created by zhaochenjun on 16/3/7.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import Alamofire

public class RESTful: NSObject {
    
    public class func passBy(data:NSDictionary, callback:(Int) -> Void) -> Void {
        
        Alamofire.request(.GET, URL_RESTFUL + "/passby", parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON))")
                }
                
                callback(0)
        }
        
        
    }
}
