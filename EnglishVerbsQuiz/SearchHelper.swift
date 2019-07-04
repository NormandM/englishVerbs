//
//  SearchHelper.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-19.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct SearcHelper {
    let filtered: [String]
    let arrayVerbe: [[String]]
    var  simplePast = [String]()
    var pastParticiple = [String]()
    init (filtered: [String], arrayVerbe: [[String]]){
        self.filtered = filtered
        self.arrayVerbe = arrayVerbe
        for verb in arrayVerbe {
            for infinitive in filtered {
                if verb[0] == infinitive{
                    simplePast.append(verb[1])
                    pastParticiple.append(verb[2])
                }
            }
        }
    }
}
