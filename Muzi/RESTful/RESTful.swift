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
        
        Alamofire.request(.GET, createRESTfulURL(RESTFUL_METHOD_PASSBY), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_PASSBY)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
        
        
    }
    
    class func passBy(data:NSDictionary, success:(AnyObject) -> Void, error:(String) -> Void) -> Void {
        
        Alamofire.request(.GET, URL_RESTFUL + createRESTfulURL(RESTFUL_METHOD_PASSBY), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_PASSBY)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
    }
    
    class func postUserGPSRecord(data:NSDictionary, success:(AnyObject) -> Void) -> Void {
       
        Alamofire.request(.POST, createRESTfulURL(RESTFUL_METHOD_POST_USER_GPS_RECORD), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_POST_USER_GPS_RECORD)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
        
        
    }
    
    class func postUserGPSRecord(data:NSDictionary, success:(AnyObject) -> Void, error:(String) -> Void) -> Void {
        
        Alamofire.request(.POST, URL_RESTFUL + createRESTfulURL(RESTFUL_METHOD_POST_USER_GPS_RECORD), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_POST_USER_GPS_RECORD)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
    }
    
    class func getUserGPSRecord(data:NSDictionary, success:(AnyObject) -> Void) -> Void {
        
        Alamofire.request(.GET, createRESTfulURL(RESTFUL_METHOD_GET_USER_GPS_RECORD), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_GET_USER_GPS_RECORD)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
        
        
    }
    
    class func getUserGPSRecord(data:NSDictionary, success:(AnyObject) -> Void, error:(String) -> Void) -> Void {
        
        Alamofire.request(.POST, URL_RESTFUL + createRESTfulURL(RESTFUL_METHOD_GET_USER_GPS_RECORD), parameters: data as? [String : AnyObject])
            .responseJSON { response in
                
                if (response.result.isSuccess){
                    
                    success(response.result.value!)
                    print("RESTful - \(RESTFUL_METHOD_GET_USER_GPS_RECORD)：\n\(response.result.value!)")
                    
                }else{
                    
                    handleCommonError(response.result.error!)
                    
                }
        }
    }
    
    private class func handleCommonError(error: NSError){
        print("RESTful，错误")
        print(error)
    }
}

