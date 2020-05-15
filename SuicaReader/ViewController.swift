//
//  ViewController.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/13.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

import UIKit
import CoreNFC

// https://ja.osdn.net/projects/felicalib/wiki/suica
// https://qiita.com/m__ike_/items/7dc3e643396cf3381167
class ViewController: UIViewController, NFCTagReaderSessionDelegate {
    
    @IBOutlet weak var scan: UIButton!
    
    var scanState:ScanState = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("start")
        
        scan.titleLabel?.font = updateFontSizeByScr(font: scan.titleLabel!.font)
    }
    
    @IBAction func OnScan(_ sender: Any) {
        if self.scanState == .none {
            startScan()
        }
    }
    
    func startScan() {
        scanState = .start
        if let session = NFCTagReaderSession(pollingOption: .iso18092, delegate: self) {
            session.alertMessage = "Suicaをかざしてください"
            session.begin()
        } else {
            print("Error")
            scanState = .none
        }
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {}

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print(error)
        self.scanState = .none
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        guard let tag = tags.first, case let .feliCa(felicaTag) = tag else { return }

        session.connect(to: tag) { error in
            self.scanState = .none
            if let error = error {
                print("Error: ", error)
                return
            }

            let historyServiceCode = Data([0x09, 0x0f].reversed()) // service code for suica. this will extract user records of train riding history.
            felicaTag.requestService(nodeCodeList: [historyServiceCode]) { nodes, error in
                if let error = error {
                    print("Error: ", error)
                    return
                }

                guard let data = nodes.first, data != Data([0xff, 0xff]) else {
                    print("unknow services")
                    return
                }

                let blockList = (0..<12).map { Data([0x80, UInt8($0)]) }
                felicaTag.readWithoutEncryption(serviceCodeList: [historyServiceCode], blockList: blockList)
                { status1, status2, dataList, error in
                    if let error = error {
                        print("Error: ", error)
                        return
                    }
                    guard status1 == 0x00, status2 == 0x00 else {
                        print("status error: ", status1, " / ", status2)
                        return
                    }
                    session.invalidate()

                    // analyze data
                    DispatchQueue.main.async {
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.appData?.createSuicaData(dataList: dataList)
                        self.performSegue(withIdentifier: "toHistory", sender: self)
                    }
                }
            }
        }
        
    }


}

