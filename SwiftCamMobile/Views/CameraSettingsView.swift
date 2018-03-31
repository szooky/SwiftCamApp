//
//  CameraSettingsView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

private struct Constants {
    static let font = UIFont(name: "Menlo-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
}

class CameraSettingsView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    let shutterSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "ss250"
        label.textColor = .white
        label.font = Constants.font
        label.textAlignment = .right

        return label
    }()

    let apetureLabel: UILabel = {
        let label = UILabel()
        label.text = "f2.8"
        label.textColor = .white
        label.font = Constants.font
        label.textAlignment = .right

        return label
    }()

    let whiteBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "6500K"
        label.textColor = .white
        label.font = Constants.font
        label.textAlignment = .right
        return label
    }()


    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        configureView()
        configureStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 30.0
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true

        stackView.addArrangedSubview(shutterSpeedLabel)
        stackView.addArrangedSubview(apetureLabel)
        stackView.addArrangedSubview(whiteBalanceLabel)
    }

    func set(shutterSpeed: String?) {
        shutterSpeedLabel.text = "ss\(shutterSpeed ?? "")"
    }

    func set(apeture: String?) {
        apetureLabel.text = "f\(apeture ?? "")"
    }

    func set(whiteBalance: String?) {
        whiteBalanceLabel.text = whiteBalance
    }

    func update(with settings: CameraSettingsModel) {
        set(apeture: settings.apeture?.description)
        set(shutterSpeed: settings.shutterSpeed?.description)
        set(whiteBalance: settings.whiteBalance?.description)
    }

}
