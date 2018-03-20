//
//  CameraSettingsView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CameraSettingsView: UIStackView {
    let shutterSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "s.s.250"
        return label
    }()

    let apetureLabel: UILabel = {
        let label = UILabel()
        label.text = "f2.8"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .darkGray
        axis = .vertical

        addArrangedSubview(shutterSpeedLabel)
        addArrangedSubview(apetureLabel)

    }

    func set(shutterSpeed: String) {
        shutterSpeedLabel.text = "s.s." + shutterSpeed
    }

    func set(apeture: String) {
        apetureLabel.text = "f" + apeture
    }

}
