//
//  ListInfinitif.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-07.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ListInfinitif {
    let arrayDictTestInfo: [[String: String]]
    let item: Int
    var infinitif: [String]
    var pastOrParticiple: [String]
    init (arrayDictTestInfo: [[String: String]], item: Int){
        self.arrayDictTestInfo = arrayDictTestInfo
        self.item = item
        infinitif = [String]()
        pastOrParticiple = [String]()
        for arrayDic in arrayDictTestInfo {
            if arrayDic["paintingNumber"] == String(item) && (arrayDic["pastGoodAnswer"] != nil){
                infinitif.append(arrayDic["infinitif"]!)
                pastOrParticiple.append(arrayDic["pastGoodAnswer"]!)
            }
        }

    }
}
