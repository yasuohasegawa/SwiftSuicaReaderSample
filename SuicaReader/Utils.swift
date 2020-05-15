//
//  Utils.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/14.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

import Foundation
import UIKit

let BASE_WIDTH = 414.0

func getScreenRatio() -> CGFloat {
    return UIScreen.main.bounds.size.width / CGFloat(BASE_WIDTH)
}

func updateFontSizeByScr(font:UIFont) -> UIFont {
    return UIFont(name: font.fontName, size: font.pointSize * getScreenRatio())!
}

func csvToArray(filename: String)->[[String]]{
    let csvFileName : String = filename.hasSuffix(".csv") ? filename.replacingOccurrences(of: ".csv", with: "") : filename
    //print(csvFileName)
    var csvData = [[String]]()
    if let csvPath = Bundle.main.path(forResource: csvFileName, ofType: "csv"){
       do{
           let fileString = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
           //print(fileString)
           let csvArray = fileString.components(separatedBy: .newlines)
           
           for line in csvArray{
               if line != "" {
                   csvData.append(line.components(separatedBy: ","))
               }
           }

       }catch let error as NSError{
           print(error.localizedDescription)
       }
    }

    return csvData
}
