//
//  MessageViewIntroduction.swift
//  PaintingsAndArtists
//
//  Created by Normand Martin on 2018-09-10.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit

class IntroductionMessage {
    
    class func showMessageView(view: UIView, messageView: UIView, visualEffect: UIVisualEffectView, effect:UIVisualEffect, pastButton: UIButton, participleButton: UIButton, seeYourAchievementButton: UIButton?){
        let fontsAndConstraints = FontsAndConstraintsOptions()
        messageView.layer.cornerRadius = 5
        messageView.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 0.7)
        view.addSubview(messageView)
        messageView.layer.borderWidth = 5
        messageView.layer.borderColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0).cgColor
        let messageViewWidth = view.frame.width * 0.7
        let messageViewHeight = view.frame.height * 0.6
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
        pastButton.titleLabel?.font = fontsAndConstraints.smallItaliqueBoldFont
        participleButton.titleLabel?.font = fontsAndConstraints.smallItaliqueBoldFont
        if let button = seeYourAchievementButton {
            button.titleLabel?.font = fontsAndConstraints.smallItaliqueBoldFont
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
enum MessageType {
    case introduction
    case endOfQuiz
    
}
