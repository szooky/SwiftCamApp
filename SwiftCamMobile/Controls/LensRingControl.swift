//
//  LensRingControl.swift
//  SwiftCamMobile
//
//  Created by Filip Szukala on 20/03/2018.
//  Copyright © 2018 Filip Szukala. All rights reserved.
//

import UIKit

protocol LensRingDelegate: class {
    func didScrollTo(selectedIndex: Int)
}

class LensRingControl: UIScrollView {
    weak var lensRingDelegate: LensRingDelegate?
    let components = ["1.4","1.8","2.0","5.6","5.6","5.6","5.6","5.6", "1.4","1.8","2.0","5.6","5.6","5.6","5.6","5.6"]
    var currentIndex = 0 {
        didSet {
            lensRingDelegate?.didScrollTo(selectedIndex: currentIndex)
        }
    }

    let gripView: UIView = {
        let view = UIView()
       view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "lensRingGrip"))
        return view
    }()

    let componentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 40.0
        stackView.distribution = .equalSpacing

        return stackView
    }()

    func configureView() {
        backgroundColor = .blue

        configureComponentsStackView()
        configureGripView()


        self.bringSubview(toFront: componentsStackView)
    }

    private func configureGripView() {
        gripView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gripView)

        gripView.widthAnchor.constraint(equalTo: componentsStackView.widthAnchor).isActive = true
        gripView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

        gripView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gripView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gripView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gripView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    private func configureComponentsStackView() {
        componentsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(componentsStackView)

        for (index, component) in components.enumerated() {
            let button = UIButton()
            button.setTitle(component, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(componentButtonClicked(_:)), for: .touchUpInside)
            componentsStackView.addArrangedSubview(button)
        }

        componentsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        componentsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        componentsStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        componentsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    @objc func componentButtonClicked(_ button: UIButton) {
        let x = button.frame.origin.x - frame.width / 2
        let point = CGPoint(x: x, y: contentOffset.y)
        setContentOffset(point, animated: true)
        currentIndex = button.tag
    }

}
