//
//  MovingViewAnimation.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-08-08.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
class MovingViewAnimation {
    class func animateViewMoving (_ up:Bool, moveValue :CGFloat, view: UIView){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        view.frame = view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }

}
