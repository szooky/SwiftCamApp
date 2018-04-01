//
//  CameraSettingsView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class SettingsDisplayView: UIView {
    let shutterSpeedLabel = CameraSettingsLabel()
    let apetureLabel = CameraSettingsLabel()
    let whiteBalanceLabel = CameraSettingsLabel()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        configureView()
        configureStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 30.0
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true

        stackView.addArrangedSubview(shutterSpeedLabel)
        stackView.addArrangedSubview(apetureLabel)
        stackView.addArrangedSubview(whiteBalanceLabel)
    }

    func update(with settings: CameraSettings) {
        if let apeture = settings.apeture?.description {
            apetureLabel.text = "f\(apeture)"
        }

        if let shutterSpeed = settings.shutterSpeed?.description {
            shutterSpeedLabel.text = "ss\(shutterSpeed)"
        }

        if let whiteBalance = settings.whiteBalance?.description {
            whiteBalanceLabel.text = whiteBalance
        }
    }
}
