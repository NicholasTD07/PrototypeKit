//
//  ViewController.swift
//  PrototypeKit
//
//  Created by nicholas.tian on 6/2/18.
//  Copyright © 2018 nickTD. All rights reserved.
//

/// RoundedShadowView itself is transparent and having the shadows.
/// The `contentView` will have concrete colors and rounded corners.
/// Use the `contentView` to add subviews.
class RoundedShadowView: UIView {
    let contentView = UIView()

    private let roundingCorners: UIRectCorner
    private let cornerRadii: CGSize
    private let shadow: Shadow

    override var backgroundColor: UIColor? {
        get {
            return self.contentView.backgroundColor
        }
        set {
            self.contentView.backgroundColor = newValue
        }
    }

    struct Shadow {
        let color: UIColor
        let radius: CGFloat
        let offset: CGSize
        let opacity: Float
    }

    init(
        byRoundingCorners roundingCorners: UIRectCorner,
        cornerRadii: CGSize,
        shadow: Shadow
    ) {
        self.roundingCorners = roundingCorners
        self.cornerRadii = cornerRadii
        self.shadow = shadow

        super.init(frame: .zero)

        setUpViews()
    }

    private func setUpViews() {
        self.backgroundColor = .clear
        self.addShadow(to: self)

        self.addSubview(contentView)
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addShadow(to view: UIView) {
        view.layer.shadowColor = self.shadow.color.cgColor
        view.layer.shadowRadius = self.shadow.radius
        view.layer.shadowOffset = self.shadow.offset
        view.layer.shadowOpacity = self.shadow.opacity
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let rect = self.contentView.bounds
        let maskPath = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: self.roundingCorners,
            cornerRadii: self.cornerRadii
        )

        let maskLayer = CAShapeLayer()

        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath

        self.contentView.layer.mask = maskLayer
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    private let contentView = RoundedShadowView(
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 16, height: 16),
        shadow: .init(
            color: .white,
            radius: 10,
            offset: CGSize(width: 0, height: -5),
            opacity: 1
        )
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .gray

        self.contentView.backgroundColor = .white
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }

    private func attempt() {
        contentView.backgroundColor = .white

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }

        addShadow(to: contentView)
    }

    private func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowOpacity = 1
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let rect = self.contentView.bounds
        let maskPath = UIBezierPath.init(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 16, height: 16)
        )

        let maskLayer = CAShapeLayer()

        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath

//        self.contentView.layer.mask = maskLayer
    }

    private func setUpLayers() {
        func circleView(diameter: CGFloat) -> UIView {
            let circle = UIView(frame: .zero)
            circle.backgroundColor = .white
            circle.layer.cornerRadius = diameter / 2
            circle.layer.masksToBounds = true

            return circle
        }
        func shadowView() -> UIView {
            let view = UIView()

            view.layer.shadowColor = UIColor.white.cgColor
            view.layer.shadowRadius = 10
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowOpacity = 1

            return view
        }

        let diameter: CGFloat = 100
        let circle = circleView(diameter: diameter)

        let shadow = shadowView()

        shadow.addSubview(circle)

        circle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(shadow)

        shadow.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(diameter)
        }
    }
}

private extension ViewController {
    private func verifySnapKitInstallation() {
        let subview = UIView()

        view.addSubview(subview)
        subview.snp.makeConstraints { make in
        }
    }
}
