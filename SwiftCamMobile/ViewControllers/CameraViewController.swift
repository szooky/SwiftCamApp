//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
    let settings = CameraSettingsModel()

    let cameraSettingsView = CameraSettingsView()
    var apetureRingView: LensRingControl!
    let cameraScreenView = UIImageView()


    override public func viewDidLoad() {
        if let view = self.view {
            view.backgroundColor = UIColor.white
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }


        addCameraControls()
        addCameraSettingsScreen()
        addApetureRing()
        addCameraScreen()
    }

    private func addCameraControls() {
        let shutterSpeedDialFrame = CGRect(origin: view.center, size: CGSize(width: 200.0, height: 200))

        let shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: settings.shutterSpeeds )
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

        apetureRingView = LensRingControl(components: settings.apetures, frame: apetureRingViewFrame)

        view.addSubview(apetureRingView)


        apetureRingView.configureView()
        apetureRingView.lensRingDelegate = self

    }

    private func addCameraScreen() {
        cameraScreenView.frame = CGRect(x: 20.0, y: 600.0, width: 400, height: 300.0)
        view.addSubview(cameraScreenView)

        cameraScreenView.image = #imageLiteral(resourceName: "alfaGirl")
        cameraScreenView.contentMode = .scaleAspectFit
    }

}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(selectedIndex: Int) {
        cameraSettingsView.set(shutterSpeed: settings.shutterSpeeds[selectedIndex].description)
        cameraScreenView.exposure(withEV: 3.0)
    }
}

extension CameraViewController: LensRingDelegate {
    func didScrollTo(selectedIndex: Int) {
        cameraSettingsView.set(apeture: settings.apetures[selectedIndex].description)
        cameraScreenView.blur(withRadius: 5.0)
    }
}
