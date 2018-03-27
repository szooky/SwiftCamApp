//
//  CameraSettingsView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CameraSettingsView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    let shutterSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "s.s.250"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        return label
    }()

    let apetureLabel: UILabel = {
        let label = UILabel()
        label.text = "f2.8"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        return label
    }()

    let whiteBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "6500K"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .black
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.addArrangedSubview(shutterSpeedLabel)
        stackView.addArrangedSubview(apetureLabel)
        stackView.addArrangedSubview(whiteBalanceLabel)
    }

    func set(shutterSpeed: String) {
        shutterSpeedLabel.text = "s.s." + shutterSpeed
    }

    func set(apeture: String) {
        apetureLabel.text = "f" + apeture
    }

    func set(whiteBalance: String) {
        whiteBalanceLabel.text = whiteBalance
    }

    func update(with settings: CameraSettingsModel) {
        set(apeture: settings.apeture?.description ?? "n/a")
        set(shutterSpeed: settings.shutterSpeed?.description ?? "n/a")
        set(whiteBalance: settings.whiteBalance?.description ?? "n/a")
    }

}
