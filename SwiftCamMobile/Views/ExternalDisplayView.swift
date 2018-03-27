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

class ExternalDisplayView: UIView {
    let foregroundImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let originalBackgroundImage: UIImage = #imageLiteral(resourceName: "alfaGirl")
    let originalForegroundImage: UIImage = #imageLiteral(resourceName: "alfaGirlForeground")

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureImageViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cameraDidTakePhoto(with settings: CameraSettingsModel) {
        setImages()
        foregroundImageView.exposure(withEV: settings.shutterSpeed?.exposure)
        backgroundImageView.exposure(withEV: settings.shutterSpeed?.exposure)
        foregroundImageView.motionBlur(withRadius: settings.shutterSpeed?.motionBlurRadius)
        backgroundImageView.motionBlur(withRadius: settings.shutterSpeed?.motionBlurRadius)
        backgroundImageView.gaussianBlur(withRadius: settings.apeture?.blurRadius)

        foregroundImageView.whiteBalance(temperature: settings.whiteBalance?.temperature)
        backgroundImageView.whiteBalance(temperature: settings.whiteBalance?.temperature)
    }

    private func configureImageViews() {
        for imageView in [backgroundImageView, foregroundImageView] {
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)

            imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }

        setImages()
    }

    private func setImages() {
        foregroundImageView.image = originalForegroundImage
        backgroundImageView.image = originalBackgroundImage
    }

}
