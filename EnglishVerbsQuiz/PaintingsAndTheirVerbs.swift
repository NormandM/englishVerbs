//
//  PaintingsAndTheirVerbs.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-05.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct PaintingsAndTheirVerbs {
    let paintingName: String
    let painter: String
    let paintingNumber: String
    let infinitif: String
    var painterBio: String
    var webAdress: String
    var painterAnniversary: String
    let simplePast: String
    let isFinished: Bool
    init(arrayDictTestInfo: [[String:String]], arrayPainting: [[String]], item: Int){
        paintingName = arrayDictTestInfo[item]["pantingTitle"]!
        painter = arrayDictTestInfo[item]["panter"]!
        paintingNumber = arrayDictTestInfo[item]["paintingNumber"]!
        if let past = arrayDictTestInfo[item]["pastGoodAnswer"]{
            simplePast = past
        }else{
            simplePast = ""
        }
        infinitif = arrayDictTestInfo[item]["infinitif"]!
        painterBio = String()
        webAdress = String()
        painterAnniversary = String()
        let isFinishedArray = IsListOfVerbsFinished().arrayIsfinished
        isFinished = isFinishedArray[Int(paintingNumber)! - 1]
        for array in arrayPainting {
            if array[2] == paintingName{
                painterBio = array[3]
                webAdress = array[4]
                painterAnniversary = array[1]
                break
            }
        }
    }
}
