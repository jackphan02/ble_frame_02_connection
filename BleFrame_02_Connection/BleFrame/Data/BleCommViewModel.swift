//
//  BleCommViewModel.swift
//  BleFrame
//
//  Created by Jack Phan on 1/11/23.
//

import SwiftUI
import CoreBluetooth

class BleCommViewModel: NSObject, ObservableObject {
    
    @Published var centralManager: CBCentralManager?
    @Published var foundOnePeripheral: UserBlePeripheral!
    @Published var foundPeripherals: [UserBlePeripheral] = []
        
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
}

extension BleCommViewModel: CBCentralManagerDelegate, CBPeripheralDelegate {
 
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("step 1")
        if(central.state == .poweredOn) {
            self.centralManager?.scanForPeripherals(withServices: nil)
            print("step 2")
        }
        
        switch central.state {
                
            case .poweredOff:
                print("Power is Off")
                
            case .poweredOn:
                print("Power is On, scanning Ble devices")
                self.centralManager?.scanForPeripherals(withServices: nil)
                
            case .unsupported:
                print("Unsupport")
                
            case .unauthorized:
                print("Unauthorized")
                
            case .unknown:
                print("Unknown")
                
            case .resetting:
                print("Resetting")
                
            @unknown default:
                print("Error")
                
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            
        foundOnePeripheral = UserBlePeripheral (
            _userPeripheral: peripheral,
            _name: peripheral.name ?? "no name",
            _rssi: RSSI.intValue
            )
        
        if !IsInFoundPeripherals(foundOnePeripheral) {
            foundPeripherals.append(foundOnePeripheral)
        }
                
    }
    
    func IsInFoundPeripherals (_ onePeripheral: UserBlePeripheral) -> Bool {
        
        // scanning filter
        for item in foundPeripherals {
            
            if item.userPeripheral.identifier.uuidString == onePeripheral.userPeripheral.identifier.uuidString {
                return true
            }
        }
        
        // not match any, this device, onePeripheral, wasn't found
        return false
    }
    
    
}
