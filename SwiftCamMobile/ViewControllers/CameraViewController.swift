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

    let cameraSettingsView = CameraSettingsView()
    var apetureRingView: LensRingControl!
    let cameraScreenView = UIImageView()
    let shutterButton = UIButton()

    override public func viewDidLoad() {
        if let view = self.view {
            view.backgroundColor = UIColor.white
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        addCameraControls()
        addCameraSettingsScreen()
        addApetureRing()
        addCameraScreen()
        addShutterButton()
    }

    private func addCameraControls() {
        let shutterSpeedDialFrame = CGRect(origin: view.center, size: CGSize(width: 200.0, height: 200))

        let shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: ShutterSpeed.all)
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

    private func addCameraScreen() {
        cameraScreenView.frame = CGRect(x: 20.0, y: 400.0, width: 400, height: 300.0)
        view.addSubview(cameraScreenView)

        cameraScreenView.image = #imageLiteral(resourceName: "alfaGirl")
        cameraScreenView.contentMode = .scaleAspectFit
    }

    private func addShutterButton() {
        shutterButton.setTitle("SHUTTER", for: .normal)
        shutterButton.setTitleColor(.blue, for: .normal)
        shutterButton.frame = CGRect(x: 20.0, y: 350.0, width: 100, height: 30)
        shutterButton.addTarget(self, action: #selector(shutterButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(shutterButton)

    }

    @objc func shutterButtonClicked(_ button: UIButton) {
        takePicture()
    }

    private func takePicture() {
        cameraScreenView.exposure(withEV: settings.shutterSpeed?.exposure)
        cameraScreenView.blur(withRadius: settings.apeture?.blurRadius)
    }
}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(selectedIndex: Int) {
        settings.shutterSpeed = ShutterSpeed.all[selectedIndex]
        takePicture()
    }
}

extension CameraViewController: LensRingDelegate {
    func didScrollTo(selectedIndex: Int) {
        settings.apeture = Apeture.all[selectedIndex]
        takePicture()
    }
}
