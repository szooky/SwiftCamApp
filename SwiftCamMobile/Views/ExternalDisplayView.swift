//
//  CameraScreen\View.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 24/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

typealias FilterKeyValue = (ImageFilterType, Any?)

class ExternalDisplayView: UIView {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    let foregroundImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let originalBackgroundImage: UIImage = #imageLiteral(resourceName: "alfaGirl")
    let originalForegroundImage: UIImage = #imageLiteral(resourceName: "alfaGirlForeground")

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureImageViews()
        configureActivityIndicatior()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cameraDidTakePhoto(with settings: CameraSettings) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .background).async { 
            let foregroundFilters = self.getForegroundFilters(with: settings)
            let foregroundImageWithFilters = CoreImageWrapper.apply(foregroundFilters, to: self.originalForegroundImage)

            let backgroundFilters = self.getBackgroundFilters(with: settings)
            let backgroundImageWithFilters = CoreImageWrapper.apply(backgroundFilters, to: self.originalBackgroundImage)

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.foregroundImageView.image = foregroundImageWithFilters
                self.backgroundImageView.image = backgroundImageWithFilters

            }
        }
    }

    private func getForegroundFilters(with settings: CameraSettings) -> [FilterKeyValue] {
        var filters = [FilterKeyValue]()

        filters.append((.motionBlur, settings.shutterSpeed?.motionBlurRadius))
        filters.append((.exposure, settings.shutterSpeed?.exposure))
      //  filters.append((.temperatureAndTint, settings.whiteBalance?.temperature))

        return filters
    }

    private func getBackgroundFilters(with settings: CameraSettings) -> [FilterKeyValue] {
        var filters = [FilterKeyValue]()

        filters.append((.motionBlur, settings.shutterSpeed?.motionBlurRadius))
        filters.append((.exposure, settings.shutterSpeed?.exposure))
    //    filters.append((.temperatureAndTint, settings.whiteBalance?.temperature))
        filters.append((.gaussianBlur, settings.apeture?.blurRadius))

        return filters
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
}
