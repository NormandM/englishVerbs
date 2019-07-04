//
//  AttributedString2.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-29.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
import UIKit

struct AttributedString2 {
    let cellString: String
    let fonts = FontsAndConstraintsOptions()
    var finalString: NSAttributedString
    init (cellString: String) {
        self.cellString = cellString
        let range = cellString.range(of: ":")
        let firstAttribute = [NSAttributedString.Key.font: fonts.normalItaliqueFont]
        let lastAttribute = [NSAttributedString.Key.font: fonts.smallBoldFont]
        let lastString = cellString[(range?.upperBound)!...]
        let firstString = cellString[...(range?.lowerBound)!]
        let firstAttributedString = NSMutableAttributedString(string: String(firstString), attributes: firstAttribute)
        let secondAttributedString = NSMutableAttributedString(string: String(lastString), attributes: lastAttribute)
        firstAttributedString.append(secondAttributedString)
        finalString = firstAttributedString
    }
}
