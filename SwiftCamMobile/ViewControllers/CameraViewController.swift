//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
    let externalDeviceView = ExternalDeviceView()
    let cameraView = CameraView()

    var settings = CameraSettings() {
        didSet {
            cameraView.cameraSettingsView.update(with: settings)
        }
    }

    override public func viewDidLoad() {
        view.backgroundColor = .white

        configureCameraView()
        configureExternalDeviceView()

        cameraView.shutterSpeedDial.layoutSubviews()
        cameraView.shutterSpeedDial.round()
    }

    private func configureCameraView() {
        view.addSubview(cameraView)

        cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        cameraView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraView.widthAnchor.constraint(equalToConstant: 600.0).isActive = true
        cameraView.heightAnchor.constraint(equalToConstant: 600.0).isActive = true

        cameraView.apetureRingView.lensRingDelegate = self
        cameraView.shutterSpeedDial.delegate = self
        cameraView.whiteBalanceDial.delegate = self

    }

    private func configureExternalDeviceView() {
        view.addSubview(externalDeviceView)
        externalDeviceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0).isActive = true
        externalDeviceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        externalDeviceView.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        externalDeviceView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }

    private func updatePhoto() {
        externalDeviceView.displayView.cameraDidTakePhoto(with: self.settings)
        print(#function)
    }
}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(rotaryWheel: RotaryWheelControl, selectedIndex: Int) {
        switch rotaryWheel {
        case cameraView.shutterSpeedDial:
            settings.shutterSpeed = ShutterSpeed.all[selectedIndex]
        case cameraView.whiteBalanceDial:
            settings.whiteBalance = WhiteBalance.all[selectedIndex]
        default:
            return
        }

        updatePhoto()
    }
}

extension CameraViewController: LensRingDelegate {
    func didScrollTo(selectedIndex: Int) {
        settings.apeture = Apeture.all[selectedIndex]
        updatePhoto()
    }
}
