//
//  ViewControllerPassBy.swift
//  Muzi
//
//  Created by 袁思曾 on 16/3/7.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewControllerPassBy: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RESTful.passBy(["ff": "22"], success: { (data : AnyObject) -> Void in
            
            })
        
        let advertisingData = [CBAdvertisementDataLocalNameKey:"",CBAdvertisementDataServiceUUIDsKey:CBUUID.init(string: "beacon")]
        
        let cbpm = CBPeripheralManager.init()
        cbpm.startAdvertising(advertisingData)
        
        let scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey:true]
        var services = [CBUUID]()
        services.append(CBUUID.init(string: "beacon"))
        
        let cm = CBCentralManager.init()
        cm.scanForPeripheralsWithServices(services, options: scanOptions)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
