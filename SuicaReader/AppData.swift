//
//  AppData.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/15.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

import Foundation

class AppData {
    var stationDB:[[String]]?
    var suicaData:[SuicaData]? = []
    
    func getDeviceTypeAndProcess(type:UInt8, data:[UInt8: String] ) -> String{
        for(key,value) in data {
            if key == type {
                return value
            }
        }
        return ""
    }
    
    func getStationName(area:String, line:UInt8, station:UInt8) -> String{
        let l = Int(line).description
        let s = Int(station).description
        
        for val in stationDB! {
            if val[0] == area && val[1] == l && val[2] == s {
                return val[3...5].map{ $0 }.joined(separator: "-")
            }
        }
        
        return ""
    }
    
    func clearSuicaData()  {
        suicaData!.removeAll()
    }
    
    func createSuicaData(dataList:[Data]) {
        clearSuicaData()
        dataList.forEach { data in
            //print("\(data[0]) \(data[4].binaryString)")
            let suica = SuicaData()
            
            print("\(data[6]) \(data[7])")
            
            let inAreaCode = String(Int(data[15] >> 6), radix: 16)
            let outAreaCode = String(Int((data[15] & 0x30) >> 4), radix: 16)
            let inStationName = self.getStationName(area: inAreaCode, line: data[6], station: data[7])
            let outtationName = self.getStationName(area: outAreaCode, line: data[8], station: data[9])
            
            let year = Int(data[4] >> 1) + 2000
            let month = ((data[4] & 1) == 1 ? 8 : 0) + Int(data[5] >> 5)
            let date = Int(data[5] & 0x1f)
            
            let credit = Int(data[10]) + Int(data[11]) << 8 // little endian
            
            suica.deviceType = self.getDeviceTypeAndProcess(type: data[0], data:Constants.deviceTypes)
            suica.process = self.getDeviceTypeAndProcess(type: data[1], data:Constants.processes)
            
            suica.date = year.description + "/" + month.description + "/" + date.description
            
            suica.inStationName = inStationName
            suica.outStationName = outtationName
            
            suica.credit = credit.description
            
            print("端末種: ",suica.deviceType as Any)
            print("処理: ",suica.process as Any)
            print("日付: ", suica.date as Any)
            print("入場駅: ", inStationName)
            print("出場駅: ", outtationName)
            
            print("入場駅コード: ", data[6...7].map { String(format: "%02x", $0) }.joined())
            print("出場駅コード: ", data[8...9].map { String(format: "%02x", $0) }.joined())
            print("入場地域コード: ", inAreaCode)
            print("出場地域コード: ", outAreaCode)
            print("残高: ", suica.credit as Any)
            suicaData!.append(suica)
        }
    }
}
