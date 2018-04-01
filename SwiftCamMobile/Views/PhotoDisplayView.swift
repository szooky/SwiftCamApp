//
//  CameraScreen\View.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

class PhotoDisplayView: UIView {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    let foregroundImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let originalBackgroundImage: UIImage = #imageLiteral(resourceName: "portraitBackground")
    let originalForegroundImage: UIImage = #imageLiteral(resourceName: "portraitForeground")

    let frameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "ipad")
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        configureFrameImageView()
        configurePhotoImageViews()
        configureActivityIndicatior()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureFrameImageView() {
        addSubview(frameImageView)
        frameImageView.edges(equalTo: self)
    }

    private func configurePhotoImageViews() {
        for imageView in [backgroundImageView, foregroundImageView] {
            addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0).isActive = true
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0).isActive = true
        }

        foregroundImageView.image = originalForegroundImage
        backgroundImageView.image = originalBackgroundImage
    }

    private func configureActivityIndicatior() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.isHidden = true
    }

    func cameraDidTakePhoto(with settings: CameraSettings) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        DispatchQueue.global(qos: .background).async {
            let foregroundImageWithFilters = CoreImageWrapper.apply(settings, to: self.originalForegroundImage, isBackground: false)
            let backgroundImageWithFilters = CoreImageWrapper.apply(settings, to: self.originalBackgroundImage, isBackground: true)

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true

                self.foregroundImageView.image = foregroundImageWithFilters
                self.backgroundImageView.image = backgroundImageWithFilters
            }
        }
    }
}
