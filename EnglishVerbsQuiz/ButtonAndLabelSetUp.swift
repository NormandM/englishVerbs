//
//  ButtonAndLabelSetUp.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-11.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
import UIKit
class OkButtonSetUp {
    
    class func dimensionAndColour (oK1Button: UIButton, oK2Button: UIButton, oK3Button: UIButton, oK4Button: UIButton){
        let fonts = FontsAndConstraintsOptions()
        oK1Button.layer.cornerRadius = oK1Button.frame.height/2
        oK2Button.layer.cornerRadius = oK2Button.frame.height/2
        oK3Button.layer.cornerRadius = oK3Button.frame.height/2
        oK4Button.layer.cornerRadius = oK4Button.frame.height/2
        oK1Button.titleLabel?.font = fonts.smallFont
        oK2Button.titleLabel?.font = fonts.smallFont
        oK3Button.titleLabel?.font = fonts.smallFont
        oK4Button.titleLabel?.font = fonts.smallFont
    }
    class func buttonHidden (oK1Button: UIButton, oK2Button: UIButton, oK3Button: UIButton, oK4Button: UIButton){
        oK1Button.isHidden = true
        oK2Button.isHidden = true
        oK3Button.isHidden = true
        oK4Button.isHidden = true
    }
    class func startQuizButtonSetUp (startQuizButton: UIButton) {
        let fonts = FontsAndConstraintsOptions()
        startQuizButton.layer.cornerRadius = startQuizButton.frame.height/2
        startQuizButton.titleLabel?.font = fonts.smallBoldFont
        startQuizButton.titleLabel?.textAlignment = .center
    }
}
