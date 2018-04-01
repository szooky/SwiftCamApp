//
//  CameraSettingsLabel.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 31/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CameraSettingsLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureApperance()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureApperance()
    }

    private func configureApperance() {
        textColor = .white
        textAlignment = .right
        font = UIFont(name: "Menlo-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
    }
}
