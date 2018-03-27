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
            cameraSettingsView.update(with: settings)
        }
    }

    let externalDeviceView = ExternalDeviceView()

    let cameraSettingsView = CameraSettingsView()
    var apetureRingView: LensRingControl!
    var shutterSpeedDial: RotaryWheelControl!
    var whiteBalanceDial: RotaryWheelControl!

    let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "camera")
        return imageView
    }()

    override public func viewDidLoad() {
        view.backgroundColor = .white

        addShutterSpeedDial()
        addCameraSettingsScreen()
        addApetureRing()

        addWhiteBalanceDial()

        addExternalDevice()
    }

    private func addExternalDevice() {
        view.addSubview(externalDeviceView)
        externalDeviceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0).isActive = true
        externalDeviceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        externalDeviceView.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        externalDeviceView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }

    private func addIpadImageView() {

    }

    private func addWhiteBalanceDial() {
        let whiteBalanceDialFrame = CGRect(origin: CGPoint(x: 200.0, y: 10.0), size: CGSize(width: 200.0, height: 200.0))


        whiteBalanceDial = RotaryWheelControl(frame: whiteBalanceDialFrame, components: WhiteBalance.all)
        whiteBalanceDial.delegate = self
        view.addSubview(whiteBalanceDial)
    }

    private func addShutterSpeedDial() {
        let shutterSpeedDialFrame = CGRect(origin: CGPoint(x: 20.0, y: 500.0), size: CGSize(width: 200.0, height: 200.0))


        shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: ShutterSpeed.all)
        shutterSpeedDial.center = view.center
        shutterSpeedDial.delegate = self
        view.addSubview(shutterSpeedDial)
    }

    private func addCameraSettingsScreen() {
        cameraSettingsView.frame = CGRect(x: 10.0, y: 20.0, width: 200.0, height: 100.0)
        view.addSubview(cameraSettingsView)
    }

    private func addApetureRing() {
        let apetureRingViewFrame = CGRect(x: 20.0, y: 150.0, width: 300, height: 100.0)
        apetureRingView = LensRingControl(components: Apeture.all, frame: apetureRingViewFrame)

        view.addSubview(apetureRingView)

        apetureRingView.configureView()
        apetureRingView.lensRingDelegate = self
    }

}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(rotaryWheel: RotaryWheelControl, selectedIndex: Int) {
        switch rotaryWheel {
        case shutterSpeedDial:
            settings.shutterSpeed = ShutterSpeed.all[selectedIndex]
        case whiteBalanceDial:
            settings.whiteBalance = WhiteBalance.all[selectedIndex]
        default:
            return

        }

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
