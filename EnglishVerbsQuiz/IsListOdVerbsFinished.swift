//
//  IsListOdVerbsFinished.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-05-15.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct IsListOfVerbsFinished{
    let numberOfPastListFinished = UserDefaults.standard.integer(forKey: "numberForQuizSimplePast")
    let numberOfParticipleFinished = UserDefaults.standard.integer(forKey: "numberForQuizPastParticiple")
    let arrayIsfinished: [Bool]
    init (){
        var arrayPastIsfInished = [Bool]()
        var arrayParticipleIsFinished = [Bool]()
        switch numberOfPastListFinished {
        case 0 :
            arrayPastIsfInished = [false, false, false, false, false, false]
        case 30:
            arrayPastIsfInished = [true, false, false, false, false, false]
        case 60:
            arrayPastIsfInished = [true, true, false, false, false, false]
        case 90:
            arrayPastIsfInished = [true, true, true, false, false, false]
        case 120:
            arrayPastIsfInished = [true, true, true, true, false, false]
        case 150:
            arrayPastIsfInished = [true, true, true, true, true, false]
        case 180 :
            arrayPastIsfInished = [true, true, true, true, true, true]
        default:
            break
        }
        switch numberOfParticipleFinished {
        case 180 :
            arrayParticipleIsFinished = [false, false, false, false, false, false]
        case 210:
            arrayParticipleIsFinished = [true, false, false, false, false, false]
        case 240:
            arrayParticipleIsFinished = [true, true, false, false, false, false]
        case 270:
            arrayParticipleIsFinished = [true, true, true, false, false, false]
        case 300:
            arrayParticipleIsFinished = [true, true, true, true, false, false]
        case 330:
            arrayParticipleIsFinished = [true, true, true, true, true, false]
        case 360 :
            arrayParticipleIsFinished = [true, true, true, true, true, true]
        default:
            break
        }
        self.arrayIsfinished = arrayPastIsfInished + arrayParticipleIsFinished
    }
}
