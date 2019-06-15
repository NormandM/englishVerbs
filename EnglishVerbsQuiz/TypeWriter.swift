//
//  TypeWriter.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-04-23.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation
class TypeWriter {
    var myCounter = 0
    var timerTyper = Timer()
    var myText: Array<String.Element>
    var verbLabel: UILabel
    var soundPlayer: SoundPlayer?
    var buttonPaintingDisplay: () -> Void
    
    init (verbLabel: UILabel, myText: Array<String.Element>, soundPlayer: SoundPlayer?, buttonPaintingDisplay: @escaping () -> Void) {
        self.myText = myText
        self.verbLabel = verbLabel
        self.soundPlayer = soundPlayer
        self.buttonPaintingDisplay = buttonPaintingDisplay
    }
    func fireTimer(){
        timerTyper = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    func stopTimer() {
        timerTyper.invalidate()
    }
    @objc func typeLetter() {
        if myCounter < myText.count {
            verbLabel.text = verbLabel.text! + String(myText[myCounter])
            let randomInterval = Double((arc4random_uniform(2)+1))/20
            timerTyper.invalidate()
            timerTyper = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector:  #selector(typeLetter), userInfo: nil, repeats: false)
        } else {
            timerTyper.invalidate()
            soundPlayer?.stopSound()
            buttonPaintingDisplay()
        }
        myCounter += 1
    }
}
