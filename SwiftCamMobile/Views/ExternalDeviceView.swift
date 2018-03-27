//
//  ExternalDeviceView.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 27/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class ExternalDeviceView: UIView {
    let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "ipad")
        return imageView
    }()

    let displayView = ExternalDisplayView()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureDeviceImageView()
        configureDisplayView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDeviceImageView() {
        addSubview(deviceImageView)
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        deviceImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        deviceImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        deviceImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func configureDisplayView() {
        deviceImageView.addSubview(displayView)
        displayView.leadingAnchor.constraint(equalTo: deviceImageView.leadingAnchor, constant: 30.0).isActive = true
        displayView.trailingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: -30.0).isActive = true
        displayView.topAnchor.constraint(equalTo: deviceImageView.topAnchor, constant: 30.0).isActive = true
        displayView.bottomAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: -30.0).isActive = true
    }
}
