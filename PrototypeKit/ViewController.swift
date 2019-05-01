//
//  ViewController.swift
//  PrototypeKit
//
//  Created by nicholas.tian on 6/2/18.
//  Copyright © 2018 nickTD. All rights reserved.
//

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        let red = UIViewController()
        red.view.backgroundColor = .red

        let green = UIViewController()
        green.view.backgroundColor = .green

        let blue = UIViewController()
        blue.view.backgroundColor = .blue

        green.addChildViewController(blue)
        blue.willMove(toParentViewController: green)
        green.view.addSubview(blue.view)
        blue.didMove(toParentViewController: green)

        blue.view.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.left.bottom.right.equalToSuperview()
        }

        let ov = OverlayContainerViewController()

        ov.delegate = self
        ov.viewControllers = [green]

        green.view.layer.cornerRadius = 8

        let stackController = StackViewController()
        stackController.viewControllers = [
            red,
            ov
        ]
        addChild(stackController, in: view)
//        stackController.willMove(toParentViewController: self)
//        self.view.addSubview(stackController.view)
//        stackController.didMove(toParentViewController: self)
        stackController.view.snp.removeConstraints()
        stackController.view.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }

    }
}

extension ViewController: OverlayContainerViewControllerDelegate {

    private enum OverlayNotch: CaseIterable {
        case minimum, medium, maximum
    }

    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }

    func overlayContainerViewController(
        _ containerViewController: OverlayContainerViewController,
        heightForNotchAt index: Int,
        availableSpace: CGFloat
        ) -> CGFloat {
        switch OverlayNotch.allCases[index] {
        case .maximum:
            return availableSpace
        case .medium:
            return availableSpace / 2
        case .minimum:
            return availableSpace * 1 / 4
        }
    }
}

private class StackViewController: UIViewController {

    var viewControllers: [UIViewController] = [] {
        didSet {
            guard isViewLoaded else { return }
            setUpViewController()
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }

    // MARK: - Private

    private func setUpViewController() {
        viewControllers.forEach { addChild($0, in: view) }
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
