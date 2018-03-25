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
    let components: [CameraParameterProtocol]
    var componentButtons = [UIButton]()
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

    init(components: [CameraParameterProtocol], frame: CGRect) {
        self.components = components
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        backgroundColor = .blue
        delegate = self
        configureComponentsStackView()
        configureGripView()


        self.bringSubview(toFront: componentsStackView)
        delaysContentTouches = true
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
            button.setTitle(component.description, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(componentButtonClicked(_:)), for: .touchUpInside)
            componentsStackView.addArrangedSubview(button)
            componentButtons.append(button)
        }

        componentsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        componentsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        componentsStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        componentsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    @objc func componentButtonClicked(_ button: UIButton) {
        scroll(to: button)
    }

    private func scroll(to button: UIButton?) {
        guard let button = button else { return }
        let x = button.frame.origin.x - frame.width / 2
        let point = CGPoint(x: x, y: contentOffset.y)
        setContentOffset(point, animated: true)
        currentIndex = button.tag
    }

    private func scrollToNearestButton() {
        let middlePoint = (frame.origin.x + frame.width) / 2
        let middlePointWithOffset = contentOffset.x + middlePoint

        var minimumDistance = CGFloat.greatestFiniteMagnitude
        var closestButton = componentButtons.first
        for button in componentButtons {
            let distance = abs(middlePointWithOffset - button.frame.origin.x)
            if distance < minimumDistance {
                minimumDistance = distance
                closestButton = button
            }
        }
        scroll(to: closestButton)
    }

}

extension LensRingControl: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollToNearestButton()
    }
}




