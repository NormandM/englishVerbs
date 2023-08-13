//
//  IrregularVerbTableViewCell.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-06-18.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit

class IrregularVerbTableViewCell: UITableViewCell {
    let notificationCenter = NotificationCenter.default
    @IBOutlet weak var infinitive: UILabel!
    @IBOutlet weak var simplePast: UILabel!
    @IBOutlet weak var PastParticiple: UILabel!
    let fonts = FontsAndConstraintsOptions()
    override func awakeFromNib() {
        super.awakeFromNib()
        infinitive.font = fonts.smallBoldFont
        simplePast.font = fonts.smallItaliqueFont
        PastParticiple.font = fonts.smallItaliqueFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
