//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
    var settings = CameraSettingsModel() {
        didSet {
            //cameraSettingsView.update(with: settings)
        }
    }

    let externalDeviceView = ExternalDeviceView()
    let cameraView = CameraView()




    override public func viewDidLoad() {
        view.backgroundColor = .white

        addCameraView()
        addExternalDeviceView()
    }

    private func addExternalDeviceView() {
        view.addSubview(externalDeviceView)
        externalDeviceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0).isActive = true
        externalDeviceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        externalDeviceView.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        externalDeviceView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }

    private func addCameraView() {
        view.addSubview(cameraView)
        cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        cameraView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraView.widthAnchor.constraint(equalToConstant: 600.0).isActive = true
        cameraView.heightAnchor.constraint(equalToConstant: 600.0).isActive = true
    }



}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(rotaryWheel: RotaryWheelControl, selectedIndex: Int) {
//        switch rotaryWheel {
//        case shutterSpeedDial:
//            settings.shutterSpeed = ShutterSpeed.all[selectedIndex]
//        case whiteBalanceDial:
//            settings.whiteBalance = WhiteBalance.all[selectedIndex]
//        default:
//            return
//
//        }

        //cameraScreenView.takePhoto(with: settings)
    }

    func didChange(selectedIndex: Int) {
        settings.shutterSpeed = ShutterSpeed.all[selectedIndex]
        //cameraScreenView.takePhoto(with: settings)
    }
}

extension CameraViewController: LensRingDelegate {
    func didScrollTo(selectedIndex: Int) {
        settings.apeture = Apeture.all[selectedIndex]
        //cameraScreenView.takePhoto(with: settings)
    }
}
