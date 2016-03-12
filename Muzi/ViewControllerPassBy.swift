//
//  ViewControllerPassBy.swift
//  Muzi
//
//  Created by 袁思曾 on 16/3/7.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation
class ViewControllerPassBy: UIViewController {
	
    @IBOutlet weak var tableInfo: UITableView!
	var peripheralManager = CBPeripheralManager()
	var centralManager = CBCentralManager()
	var service = CBMutableService!()
    var uuid = NSUUID().UUIDString
    var arrayDevice = Array<AnyObject>()
    var peri:CBPeripheral!
	
	var arrayRSSILabel = Array<UILabel>()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.peri = CBPeripheral.initialize()

        
        RESTful.postUserGPSRecord(["username": "whoever","date":"2016-03-11 17:00:00","lat":121.231313124,"lon":170.12312313], success: { (data : AnyObject) -> Void in
            // 请求成功回调
            })
        
        RESTful.getUserGPSRecord(["username": "whoever"], success: { (data : AnyObject) -> Void in
            // 数据在data里
        })
        
		//self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
		
		//self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
		//self.tableInfo.delegate = self
		//self.tableInfo.dataSource = self
		
		
        
        // Do any additional setup after loading the view.
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	/*
	func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //print (RSSI)
        //textViewInfo.text = RSSI.stringValue
		//print(peripheral.valueForKey(CBAdvertisementDataLocalNameKey))
		//let s = peripheral.services?.last
        
        //let newInfo = []
        //newInfo.setValue(peripheral.identifier.UUIDString, forKey: "UUID")
        //newInfo.setValue(RSSI.stringValue, forKey: "RSSI")
        
        let newInfo = NSMutableDictionary()
        newInfo.setValue(peripheral.identifier.UUIDString, forKey: "UUID")
        newInfo.setValue(RSSI.stringValue, forKey: "RSSI")
      //  print(advertisementData)

       // ["UUID": peripheral.identifier.UUIDString, "RSSI": RSSI.stringValue]
        var hasRecord = false
        
        for (var i = 0; i < self.arrayDevice.count; i++){
            
            let deviceInfo = self.arrayDevice[i]
            
            //print(deviceInfo.objectForKey("UUID")?.stringValue)
            if((deviceInfo.objectForKey("UUID") as! String) == peripheral.identifier.UUIDString){
                deviceInfo.setObject(RSSI.stringValue, forKey: "RSSI")
                
//                if (self.tableInfo.numberOfRowsInSection(0) > i){
//                    self.tableInfo.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: i, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
//                }
//
				let label = self.arrayRSSILabel[i]
				label.text = RSSI.stringValue
				
                hasRecord = true
            }
        }
        
        if(!hasRecord){
			
            self.arrayDevice.append(newInfo)
            tableInfo.reloadData()
            self.peri = peripheral
            
            central.connectPeripheral(peripheral, options: nil)
            
        }
        
	}
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.delegate = self;
        peripheral.discoverServices(nil)
    }
	
	
	func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
		print("失去连接：\(peripheral.identifier)")
	}
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        let services = peripheral.services
        for ser in services!{
            peripheral.discoverCharacteristics(nil, forService: ser)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if let charactericsArr = service.characteristics
        {
            for charactericsx in charactericsArr
            {
               // peripheral.setNotifyValue(true, forCharacteristic: charactericsx)
                
                print("Characteristic: \(charactericsx.UUID)")
                print("service: \(service.UUID)")
                //textField.text = textField.text + "Characteristic: \(charactericsx)\n"
                
               // peripheral.readValueForCharacteristic(charactericsx)
            }
            
        }
    }
	
	
    
    func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        print("rrrrrrr")
    }
	
	func centralManagerDidUpdateState(central: CBCentralManager) {
		//print (central)
		let scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey:true]
		var services = [CBUUID]()
		services.append(CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48"))
		
		//self.centralMana
		self.centralManager.scanForPeripheralsWithServices(nil, options: scanOptions)
	}
	
	func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
		print(peripheral.state == CBPeripheralManagerState.PoweredOn)
		
		let serviceUUID = CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48")
        
//        CBMutableCharacteristic *transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"Characteristic name"]
//            properties:CBCharacteristicPropertyRead
//            value:[@"Test value" dataUsingEncoding:NSUTF8StringEncoding]
//            permissions:CBAttributePermissionsReadable];
        let transferCharacteristic = CBMutableCharacteristic.init(type: serviceUUID, properties: CBCharacteristicProperties.Read, value: "Test value".dataUsingEncoding(NSUTF8StringEncoding), permissions: CBAttributePermissions.Readable)
        
		self.service=CBMutableService(type: serviceUUID, primary: true)
        self.service.characteristics = [transferCharacteristic as CBCharacteristic]
		self.peripheralManager.addService(service)
		
	}
	
	func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
		//print(error)
		//print("开始发送")
		
		var servicesKey = [CBUUID]()
		servicesKey.append(CBUUID.init(string: "6D036878-2753-4A7C-8F16-34D7E5E8DF48"))
		
		let advertisingData = [CBAdvertisementDataLocalNameKey:"my-peripheral",CBAdvertisementDataServiceUUIDsKey:servicesKey]
		self.peripheralManager.startAdvertising(advertisingData as? [String : AnyObject])
	}
	
	func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
		//print(error)
        //print("发送advertising成功")
	}
	
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayDevice.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = self.arrayDevice[indexPath.row].objectForKey("UUID") as? String
        cell.detailTextLabel?.text = arrayDevice[indexPath.row].objectForKey("RSSI")as? String
		
		if (self.arrayRSSILabel.count == indexPath.row){
			self.arrayRSSILabel.append(cell.detailTextLabel!)
		}
       // print(self.arrayDevice)
        return cell
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
