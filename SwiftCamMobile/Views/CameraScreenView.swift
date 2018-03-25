//
//  CameraScreen\View.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

enum PictureType {
    case portrait
    case nightLandscape
    case sport
}

class CameraScreenView: UIView {
    let foregroundImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let originalImage: UIImage = #imageLiteral(resourceName: "alfaGirl")

    func takePhoto(with settings: CameraSettingsModel) {
        foregroundImageView.image = originalImage
        foregroundImageView.exposure(withEV: settings.shutterSpeed?.exposure)
        foregroundImageView.blur(withRadius: settings.apeture?.blurRadius)
    }

    func configureView() {
        configureForegroundImageView()
    }

    private func configureForegroundImageView() {
        foregroundImageView.image = originalImage
        foregroundImageView.contentMode = .scaleAspectFit
        foregroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(foregroundImageView)

        foregroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        foregroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        foregroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        foregroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func configureBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFit
    }

}
