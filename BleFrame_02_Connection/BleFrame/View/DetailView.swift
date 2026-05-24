//
//  DetailView.swift
//  BleFrame
//
//  Created by Jack Phan on 1/12/23.
//

import SwiftUI
import CoreBluetooth

struct DetailView: View {
    
    @StateObject public var oneDev: UserBlePeripheral
    @StateObject public var bleViewModel: BleCommViewModel
    @State var connectionStatus: String = "Connecting ..."
    
    var body: some View {
        
        NavigationStack{
            
            Text(oneDev.name)
            Spacer().frame(height: 20)
            
            if oneDev.userPeripheral.state == CBPeripheralState.connected {
                Text("Connected")
            }
            else {
                
                // indicator the connection in progress
                Text("\(connectionStatus)")
                
                // setting timout
                var count = 0
                let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if (count >= 3) {   // waiting in seconds
                        connectionStatus = "Cannot connect"
                        timer.invalidate()
                    }
                    count += 1
                }
            }
            
        }
        .onAppear{
            
            bleViewModel.centralManager?.connect(oneDev.userPeripheral)
            //print("Connecting")
        }
        
    }

}

