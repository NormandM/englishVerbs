//
//  RulesforConjugation.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-25.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
class RulesforConjugation {
    var conjugationRule1: String
    let conjugationRule2: String
    let conjugationRule3: String
    let conjugationRule4: String
    let conjugationRule5: String
    let conjugationRule6: String
    let isIrregularVerb: Bool
    init(infinitif: String, infiniveIrregular: [String],  tempsDuVerbe: String){
        print("infinitif: \(infinitif)")
        let modeAndTemp = ModeAndTemp()
        let pattern = modeAndTemp.pattern
        let temp = modeAndTemp.tempContexte
        if let indexOftemp = temp.firstIndex(of: tempsDuVerbe){
            let count = pattern[indexOftemp].count
            var c1 = String()
            var c2 = String()
            var c3 = String()
            var c4 = String()
            var c5 = String()
            var c6 = String()
            switch count {
            case 3:
                c1 = pattern[indexOftemp][0]
                c2 = pattern[indexOftemp][1]
                c3 = pattern[indexOftemp][2]
                c4 = ""
                c5 = ""
                c6 = ""
            case 4:
                c1 = pattern[indexOftemp][0]
                c2 = pattern[indexOftemp][1]
                c3 = pattern[indexOftemp][2]
                c4 = pattern[indexOftemp][3]
                c5 = ""
                c6 = ""
            case 5:
                c1 = pattern[indexOftemp][0]
                c2 = pattern[indexOftemp][1]
                c3 = pattern[indexOftemp][2]
                c4 = pattern[indexOftemp][3]
                c5 = pattern[indexOftemp][4]
                c6 = ""
            case 6:
                c1 = pattern[indexOftemp][0]
                c2 = pattern[indexOftemp][1]
                c3 = pattern[indexOftemp][2]
                c4 = pattern[indexOftemp][3]
                c5 = pattern[indexOftemp][4]
                c6 = pattern[indexOftemp][5]
            default:
                c1 = ""
                c2 = ""
                c3 = ""
                c4 = ""
                c5 = ""
                c6 = ""
            }
            conjugationRule1 = c1
            conjugationRule2 = c2
            conjugationRule3 = c3
            conjugationRule4 = c4
            conjugationRule5 = c5
            conjugationRule6 = c6
        }else{
            conjugationRule1 = "Did not find the rules"
            conjugationRule2 = "Did not find the rules"
            conjugationRule3 = "Did not find the rules"
            conjugationRule4 = "Did not find the rules"
            conjugationRule5 = "Did not find the rules"
            conjugationRule6 = "Did not find the rules"
        }
        if infiniveIrregular.contains(infinitif) {
            isIrregularVerb = true
        }else{
             isIrregularVerb = false
        }
    }
}
