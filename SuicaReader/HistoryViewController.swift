//
//  HistoryViewController.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/14.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var index = 0
    
    @IBOutlet weak var deviceLb: UILabel!
    @IBOutlet weak var processLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var inStationLb: UILabel!
    @IBOutlet weak var outStationLb: UILabel!
    @IBOutlet weak var creditLb: UILabel!
    
    @IBOutlet weak var deviceVal: UILabel!
    @IBOutlet weak var processVal: UILabel!
    @IBOutlet weak var dateVal: UILabel!
    @IBOutlet weak var inStationVal: UILabel!
    @IBOutlet weak var outStationVal: UILabel!
    @IBOutlet weak var creditVal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceLb.font = updateFontSizeByScr(font:deviceLb.font)
        processLb.font = updateFontSizeByScr(font:processLb.font)
        dateLb.font = updateFontSizeByScr(font:dateLb.font)
        inStationLb.font = updateFontSizeByScr(font:inStationLb.font)
        outStationLb.font = updateFontSizeByScr(font:outStationLb.font)
        creditLb.font = updateFontSizeByScr(font:creditLb.font)
        
        deviceVal.font = updateFontSizeByScr(font:deviceVal.font)
        processVal.font = updateFontSizeByScr(font:processVal.font)
        dateVal.font = updateFontSizeByScr(font:dateVal.font)
        inStationVal.font = updateFontSizeByScr(font:inStationVal.font)
        outStationVal.font = updateFontSizeByScr(font:outStationVal.font)
        creditVal.font = updateFontSizeByScr(font:creditVal.font)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        print(parent as Any);
        if(parent == nil) {
            // back
        } else {
            // this calls when it comes from the parent view
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let data = appDelegate.appData?.suicaData?[index]
            deviceVal.text = data?.deviceType
            processVal.text = data?.process
            dateVal.text = data?.date
            inStationVal.text = data?.inStationName
            outStationVal.text = data?.outStationName
            creditVal.text = data?.credit
        }
    }
}
