//
//  UserBlePeripheral.swift
//  BleFrame
//
//  Created by Jack Phan on 1/11/23.
//

import CoreBluetooth

class UserBlePeripheral: Identifiable, ObservableObject {
    
    @Published var id: UUID
    @Published var userPeripheral: CBPeripheral
    @Published var name: String
    @Published var rssi: Int
    
    init(_userPeripheral: CBPeripheral,
         _name: String,
         _rssi: Int
         )
    {
        id = UUID()
        userPeripheral = _userPeripheral
        name = _name
        rssi = _rssi

    }
    
}

