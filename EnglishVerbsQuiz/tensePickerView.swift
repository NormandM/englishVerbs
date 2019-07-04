//
//  MessageViewIntroduction.swift
//  PaintingsAndArtists
//
//  Created by Normand Martin on 2018-09-10.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit

class TensePickViewMessage {
    class func showPickerView(view: UIView, messageView: UIView, visualEffect: UIVisualEffectView, effect:UIVisualEffect, title: UILabel, okButton: UIButton){
        let fontsAndConstraints = FontsAndConstraintsOptions()
        messageView.layer.cornerRadius = 5
        messageView.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 0.7)
        view.addSubview(messageView)
        messageView.layer.borderWidth = 5
        messageView.layer.borderColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0).cgColor
        let messageViewWidth = view.frame.width * 0.95
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
        title.textColor = UIColor.white
        title.text = """
        Understand Verb Forms
        and their Combinations
        """
        okButton.titleLabel?.textColor = UIColor.white
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = fontsAndConstraints.largeBoldFont
    }
    class func dismissMessageview(messageView: UIView, visualEffect: UIVisualEffectView, effect:UIVisualEffect) {
        UIView.animate(withDuration: 0.8, animations: {
            messageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            messageView.alpha = 0
            //visualEffect.effect = nil
            visualEffect.removeFromSuperview()
        }) { (success: Bool) in
            messageView.removeFromSuperview()
        }
    }
}


