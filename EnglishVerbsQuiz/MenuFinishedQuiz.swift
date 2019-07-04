//
//  MenuFinishedQuiz.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-04.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
class MenuFinishedQuiz {
    class func showMessageView(view: UIView, messageView: UIView, visualEffect: UIVisualEffectView, effect:UIVisualEffect, title: UILabel, pastButton: UIButton, participleButton: UIButton, consultAndLearnLabel: UILabel?, seeYourAchievementButton: UIButton?){
        let colorReference = ColorReference()
        let fontsAndConstraints = FontsAndConstraintsOptions()
        messageView.layer.cornerRadius = 5
        messageView.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 0.7)
        view.addSubview(messageView)
        messageView.layer.borderWidth = 5
        messageView.layer.borderColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0).cgColor
        let messageViewWidth = view.frame.width * 0.7
        let messageViewHeight = view.frame.height * 0.4
        let messageXPosition = view.frame.size.width  / 2 - messageViewWidth/2
        let messageYPosition = view.frame.size.height/2 - messageViewHeight/2
        messageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        messageView.alpha = 0
        UIView.animate(withDuration: 0.8) {
            visualEffect.effect = effect
            messageView.alpha = 1.0
            messageView.transform = CGAffineTransform.identity
        }
        messageView.frame = CGRect(x: messageXPosition, y: messageYPosition , width: messageViewWidth, height: messageViewHeight)
        title.font = fontsAndConstraints.normalBoldFont
        title.textColor = colorReference.specialGray
        pastButton.titleLabel?.font = fontsAndConstraints.normalBoldFont
        participleButton.titleLabel?.font = fontsAndConstraints.normalBoldFont
        if let button = seeYourAchievementButton {
            button.titleLabel?.font = fontsAndConstraints.normalBoldFont
        }
        
        if let label = consultAndLearnLabel {
            label.font = fontsAndConstraints.normalItaliqueFont
            label.textColor = colorReference.specialGray
        }
    }
    class func dismissMessageview(messageView: UIView, visualEffect: UIVisualEffectView, effect:UIVisualEffect) {
        UIView.animate(withDuration: 0.8, animations: {
            messageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            messageView.alpha = 0
            visualEffect.effect = nil
        }) { (success: Bool) in
            messageView.removeFromSuperview()
        }
    }
}
