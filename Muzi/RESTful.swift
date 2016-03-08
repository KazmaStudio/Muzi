//
//  RESTful.swift
//  Muzi
//
//  Created by zhaochenjun on 16/3/7.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import Alamofire

class RESTful: NSObject {
    
    class func passBy(data:NSDictionary, success:(AnyObject) -> Void) -> Void {
        
        Alamofire.request(.GET, createRESTfulURL(METHOD_PASSBY), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(METHOD_PASSBY)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError()
                    
                }
        }
        
        
    }
    
    class func passBy(data:NSDictionary, success:(AnyObject) -> Void, error:(String) -> Void) -> Void {
        
        Alamofire.request(.GET, URL_RESTFUL + createRESTfulURL(METHOD_PASSBY), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(METHOD_PASSBY)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError()
                    
                }
        }
    }
    
    private class func handleCommonError(){
        print("RESTful，错误")
    }
}

