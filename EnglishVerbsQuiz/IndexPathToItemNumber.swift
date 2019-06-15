//
//  IndexPathToItemNumber.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-09.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct IndexPathToItemNumber {
    let indexPath: IndexPath
    let paintingNumber: Int
    let paintingNumberFromTest: Int
    init(indexPath: IndexPath){
        var itemNumber = Int()
        var itemPainting = Int()
        self.indexPath = indexPath
        switch indexPath {
        case [0,0]:
            itemNumber = 1
            itemPainting = 0
        case [0,1]:
            itemNumber = 2
            itemPainting = 30
        case [0,2]:
            itemNumber = 3
            itemPainting = 60
        case [0,3]:
            itemNumber = 4
            itemPainting = 90
        case [0,4]:
            itemNumber = 5
            itemPainting = 120
        case [0,5]:
            itemNumber = 6
            itemPainting = 150
        case [1,0]:
            itemNumber = 7
            itemPainting = 180
        case [1,1]:
            itemNumber = 8
            itemPainting = 210
        case [1,2]:
            itemNumber = 9
            itemPainting = 240
        case [1,3]:
            itemNumber = 10
            itemPainting = 270
        case [1,4]:
            itemNumber = 11
            itemPainting = 300
        case [1,5]:
            itemNumber = 12
            itemPainting = 330
            
        default:
            break
        }
        paintingNumber = itemNumber
        paintingNumberFromTest = itemPainting
    }
}
