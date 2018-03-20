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
        let shutterSpeedValues = ["100"]
        let shutterSpeedDialFrame = CGRect(x: 20.0, y: 20.0, width: 100.0, height: 100.0)
        let shutterSpeedDial = CircularDial(frame: shutterSpeedDialFrame, values: shutterSpeedValues )
        view.addSubview(shutterSpeedDial)
    }



}
