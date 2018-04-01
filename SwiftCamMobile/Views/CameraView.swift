//
//  CameraView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 27/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class CameraView: UIView {
    let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "camera")
        return imageView
    }()

    let cameraSettingsView = SettingsDisplayView()
    let shutterSpeedDial = RotaryDial(components: ShutterSpeed.all)
    let whiteBalanceDial = RotaryDial(components: WhiteBalance.all)
    let apetureRingView = LensRing(components: Apeture.all)

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true

        configureCameraImageView()
        configureCameraSettingsScreen()
        configureShutterSpeedDial()
        configureWhiteBalanceDial()
        configureApetureRing()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCameraImageView() {
        addSubview(cameraImageView)
        cameraImageView.isUserInteractionEnabled = true
        cameraImageView.edges(equalTo: self)
    }

    private func configureCameraSettingsScreen() {
        cameraImageView.addSubview(cameraSettingsView)

        cameraSettingsView.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor, constant: 30.0).isActive = true
        cameraSettingsView.bottomAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: -120.0).isActive = true
        cameraSettingsView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        cameraSettingsView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }

    private func configureShutterSpeedDial() {
        cameraImageView.addSubview(shutterSpeedDial)

        shutterSpeedDial.translatesAutoresizingMaskIntoConstraints = false
        shutterSpeedDial.trailingAnchor.constraint(equalTo: cameraImageView.trailingAnchor, constant: -120.0).isActive = true
        shutterSpeedDial.bottomAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: -107.0).isActive = true
        shutterSpeedDial.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        shutterSpeedDial.heightAnchor.constraint(equalToConstant: 120.0).isActive = true

        shutterSpeedDial.configureView()
    }

    private func configureWhiteBalanceDial() {
        cameraImageView.addSubview(whiteBalanceDial)

        whiteBalanceDial.translatesAutoresizingMaskIntoConstraints = false
        whiteBalanceDial.trailingAnchor.constraint(equalTo: cameraImageView.trailingAnchor, constant: 0.0).isActive = true
        whiteBalanceDial.bottomAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: -103).isActive = true
        whiteBalanceDial.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        whiteBalanceDial.heightAnchor.constraint(equalToConstant: 90.0).isActive = true

        whiteBalanceDial.configureView()
    }

    private func configureApetureRing() {
        cameraImageView.addSubview(apetureRingView)
        apetureRingView.translatesAutoresizingMaskIntoConstraints = false
        apetureRingView.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor, constant: 125.0).isActive = true
        apetureRingView.topAnchor.constraint(equalTo: cameraImageView.topAnchor, constant: 250.0).isActive = true
        apetureRingView.widthAnchor.constraint(equalToConstant: 280.0).isActive = true
        apetureRingView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        apetureRingView.configureView()
    }
}

