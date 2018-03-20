//
//  CameraViewController.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {

    override public func viewDidLoad() {
        if let view = self.view {
            view.backgroundColor = UIColor.white
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        addControls()
    }

    private func addControls() {
        let shutterSpeedValues = ["A", "4000", "2000", "1000", "500", "250"]
        let shutterSpeedDialFrame = CGRect(origin: view.center, size: CGSize(width: 300.0, height: 300.0))

        let shutterSpeedDial = RotaryWheelControl(frame: shutterSpeedDialFrame, components: shutterSpeedValues )
        shutterSpeedDial.center = view.center
        view.addSubview(shutterSpeedDial)
    }



}
