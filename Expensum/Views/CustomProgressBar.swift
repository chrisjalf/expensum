//
//  CustomProgressBar.swift
//  Expensum
//
//  Created by Chris James on 20/03/2022.
//

import UIKit

class CustomProgressBar: UIView {
    var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        //backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: 30).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))

        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color.cgColor
    }
}
