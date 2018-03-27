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

    let cameraSettingsView = CameraSettingsView()



    var apetureRingView: LensRingControl!
    var shutterSpeedDial: RotaryWheelControl!
    var whiteBalanceDial: RotaryWheelControl!

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        configureCameraImageView()
        addWhiteBalanceDial()
        addShutterSpeedDial()
        addApetureRing()
        addCameraSettingsScreen()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCameraImageView() {
        addSubview(cameraImageView)
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        cameraImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cameraImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cameraImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cameraImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func addCameraSettingsScreen() {
        cameraImageView.addSubview(cameraSettingsView)
        cameraSettingsView.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor, constant: 30.0).isActive = true
        cameraSettingsView.bottomAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: -120.0).isActive = true
        cameraSettingsView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        cameraSettingsView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }


    private func addWhiteBalanceDial() {
        let whiteBalanceDialFrame = CGRect(origin: CGPoint(x: 200.0, y: 10.0), size: CGSize(width: 200.0, height: 200.0))


        whiteBalanceDial = RotaryWheelControl(frame: whiteBalanceDialFrame, components: WhiteBalance.all)
        addSubview(whiteBalanceDial)
    }

    private func addShutterSpeedDial() {
        let shutterSpeedDialFrame = CGRect(origin: CGPoint(x: 20.0, y: 500.0), size: CGSize(width: 200.0, height: 200.0))


        shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: ShutterSpeed.all)
        shutterSpeedDial.center = center
        addSubview(shutterSpeedDial)
    }


    private func addApetureRing() {
        let apetureRingViewFrame = CGRect(x: 20.0, y: 150.0, width: 300, height: 100.0)
        apetureRingView = LensRingControl(components: Apeture.all, frame: apetureRingViewFrame)

        addSubview(apetureRingView)

        apetureRingView.configureView()
    }


}

