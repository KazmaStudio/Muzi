//
//  ViewControllerPassBy.swift
//  Muzi
//
//  Created by 袁思曾 on 16/3/7.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewControllerPassBy: UIViewController, CBCentralManagerDelegate, CBPeripheralManagerDelegate {
	
	var peripheralManager = CBPeripheralManager()
	var centralManager = CBCentralManager()
	var service = CBMutableService!()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RESTful.passBy(["ff": "22"], success: { (data : AnyObject) -> Void in
            
            })
        
		self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
		
		self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
		
		
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
		print (RSSI)
		//print(peripheral.valueForKey(CBAdvertisementDataLocalNameKey))
		//let s = peripheral.services?.last
		print(advertisementData)
	}
	
	func centralManagerDidUpdateState(central: CBCentralManager) {
		print (central)
		let scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey:true]
		var services = [CBUUID]()
		services.append(CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48"))
		
		
		self.centralManager.scanForPeripheralsWithServices(services, options: scanOptions)
	}
	
	func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
		print(peripheral.state == CBPeripheralManagerState.PoweredOn)
		
		let serviceUUID = CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48")
		self.service=CBMutableService(type: serviceUUID, primary: true)
		self.peripheralManager.addService(service)
		
		
	}
	
	func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
		print(error)
		print("开始发送")
		
		var servicesKey = [CBUUID]()
		servicesKey.append(CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48"))
		
		let advertisingData = [CBAdvertisementDataLocalNameKey:"my-peripheral",CBAdvertisementDataServiceUUIDsKey:servicesKey]
		self.peripheralManager.startAdvertising(advertisingData as? [String : AnyObject])
	}
	
	func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
		print(error)
		print("发送advertising成功")
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
