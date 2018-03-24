//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
    let cameraSettingsView = CameraSettingsView()
    let shutterSpeedValues = ["A", "4000", "2000", "1000", "500", "250", "180x", "125", "60", "30", "15", "8", "4", "2", "1","B"]
    let apetureRingView = LensRingControl()

    override public func viewDidLoad() {
        if let view = self.view {
            view.backgroundColor = UIColor.white
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        addCameraControls()
        addCameraSettingsScreen()
        addApetureRing()
    }

    private func addCameraControls() {
        let shutterSpeedDialFrame = CGRect(origin: view.center, size: CGSize(width: 200.0, height: 200))

        let shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: shutterSpeedValues )
        shutterSpeedDial.center = view.center
        shutterSpeedDial.delegate = self
        view.addSubview(shutterSpeedDial)


        let exposureDialValues = ["0","+1","+2","+3", "C","-3","-2","-1"]
        let exposureDialFrame = CGRect(origin: view.center, size: CGSize(width: 150.0, height: 150))
        let exposureDial = RotaryWheelControl(frame: exposureDialFrame, components: exposureDialValues)

        exposureDial.center.x = view.center.x
        exposureDial.frame.origin.y = shutterSpeedDial.frame.origin.y + shutterSpeedDial.frame.height + 10.0
        view.addSubview(exposureDial)

    }

    private func addCameraSettingsScreen() {
        cameraSettingsView.frame = CGRect(x: 10.0, y: 20.0, width: 200.0, height: 100.0)
        view.addSubview(cameraSettingsView)
    }

    private func addApetureRing() {

        apetureRingView.frame = CGRect(x: 20.0, y: 150.0, width: 600, height: 100.0)
        view.addSubview(apetureRingView)


        apetureRingView.configureView()

    }

}

extension CameraViewController: RotaryWheelDelegate {
    func didChange(selectedIndex: Int) {
        cameraSettingsView.set(shutterSpeed: shutterSpeedValues[selectedIndex])
    }
}
