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

class LensRingControl: UIView {
    weak var lensRingDelegate: LensRingDelegate?
    let components: [CameraParameterProtocol]
    var componentButtons = [UIButton]()
    var currentIndex = 0 {
        didSet {
            lensRingDelegate?.didScrollTo(selectedIndex: currentIndex)
        }
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()

    let gripView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "lensGrip"))
        return view
    }()

    let componentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 40.0
        stackView.distribution = .equalSpacing

        return stackView
    }()

    let leftGradientView: UIView = {
        let view = UIView()
        return view
    }()

    let rightGradientView: UIView = {
        let view = UIView()
        return view
    }()

    init(components: [CameraParameterProtocol]) {
        self.components = components
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5.0
        clipsToBounds = true

        leftGradientView.addGradient(direction: .leftToRight, colors: .blackToOpaque)
        rightGradientView.addGradient(direction: .rightToLeft, colors: .blackToOpaque)
    }

    func configureView() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .black
        configureScrollView()
        configureComponentsStackView()
        configureGripView()
        configureLeftGradientView()
        configureRightGradientView()

        scrollView.bringSubview(toFront: componentsStackView)
    }

    private func configureScrollView() {
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delaysContentTouches = true

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func configureComponentsStackView() {
        componentsStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(componentsStackView)

        for (index, component) in components.enumerated() {
            let button = UIButton()
            button.setTitle(component.description, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(componentButtonClicked(_:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)

            componentsStackView.addArrangedSubview(button)
            componentButtons.append(button)
        }

        componentsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        componentsStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.25).isActive = true
    }

    private func configureGripView() {
        gripView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(gripView)

        gripView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.75).isActive = true
        gripView.widthAnchor.constraint(equalTo: componentsStackView.widthAnchor, multiplier: 2.0).isActive = true

        gripView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        gripView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        gripView.topAnchor.constraint(equalTo: componentsStackView.bottomAnchor).isActive = true
        gripView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        componentsStackView.centerXAnchor.constraint(equalTo: gripView.centerXAnchor).isActive = true
    }

    private func configureLeftGradientView() {
        addSubview(leftGradientView)
        leftGradientView.translatesAutoresizingMaskIntoConstraints = false
        leftGradientView.isUserInteractionEnabled = false
        leftGradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftGradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftGradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftGradientView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }

    private func configureRightGradientView() {
        addSubview(rightGradientView)
        rightGradientView.translatesAutoresizingMaskIntoConstraints = false
        rightGradientView.isUserInteractionEnabled = false
        rightGradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rightGradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightGradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightGradientView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }

    @objc func componentButtonClicked(_ button: UIButton) {
        scroll(to: button)
    }

    private func scroll(to button: UIButton?) {
        guard let button = button else { return }
        let buttonCenterOnSuperview = convert(button.center, to: superview)
        let pointToScroll = CGPoint(x: buttonCenterOnSuperview.x, y: scrollView.contentOffset.y)
        scrollView.setContentOffset(pointToScroll, animated: true)
        lensRingDelegate?.didScrollTo(selectedIndex: button.tag)
    }

    private func scrollToNearestButton() {
        var minimumDistance = CGFloat.greatestFiniteMagnitude
        var closestButton = componentButtons.first

        for button in componentButtons {
            let buttonCenterOnSuperview = convert(button.center, to: superview)
            let distance = abs(scrollView.contentOffset.x - buttonCenterOnSuperview.x)

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
        if !decelerate {
           scrollToNearestButton()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       scrollToNearestButton()
    }
}
