//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
    let photoDisplayView = PhotoDisplayView()
    let cameraView = CameraView()

    var settings = CameraSettings() {
        didSet {
            cameraView.cameraSettingsView.update(with: settings)
        }
    }

    override public func viewDidLoad() {
        view.backgroundColor = .white

        configureCameraView()
        configurePhotoDisplayView()
    }

    private func configureCameraView() {
        view.addSubview(cameraView)

        cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        cameraView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraView.widthAnchor.constraint(equalToConstant: 600.0).isActive = true
        cameraView.heightAnchor.constraint(equalToConstant: 600.0).isActive = true

        cameraView.apetureRingView.delegate = self
        cameraView.shutterSpeedDial.delegate = self
        cameraView.whiteBalanceDial.delegate = self
    }

    private func configurePhotoDisplayView() {
        view.addSubview(photoDisplayView)
        photoDisplayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0).isActive = true
        photoDisplayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoDisplayView.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        photoDisplayView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
}

extension CameraViewController: SelectableControlDelegate {
    func didSelect(index: Int, in control: Selectable?) {
        switch control as? UIView {
        case cameraView.shutterSpeedDial:
            settings.shutterSpeed = ShutterSpeed.all[index]
        case cameraView.whiteBalanceDial:
            settings.whiteBalance = WhiteBalance.all[index]
        case cameraView.apetureRingView:
            settings.apeture = Apeture.all[index]
        default:
            return
        }

        photoDisplayView.cameraDidTakePhoto(with: settings)
    }
}
