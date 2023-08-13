//
//  Extension.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2023-08-04.
//  Copyright © 2023 Normand Martin. All rights reserved.
//

import UIKit
extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
