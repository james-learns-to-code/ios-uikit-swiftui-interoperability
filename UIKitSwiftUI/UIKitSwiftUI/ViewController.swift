//
//  ViewController.swift
//  UIKitSwiftUI
//
//  Created by Dongseok Lee on 12/13/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    // Universal ViewModel for UIViewController/SwiftUI.View
    private let viewModel = SwiftUIViewModel(title: "Hello, World!")

    // SwiftUI Adaptor
    private var hostingController: UIHostingController<SwiftUIView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = SwiftUIView(
            viewModel: self.viewModel,
            onBodyTapped: { [weak self] in
                self?.viewModel.title = "Tapped!"
            }
        )

        let hostingController = UIHostingController(rootView: swiftUIView)
        add(hostingController, in: self.view, signalLifecycle: true)
        self.hostingController = hostingController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hostingController?.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        hostingController?.viewWillTransition(to: size, with: coordinator)
        viewModel.title = "Rotated!"
    }
}

// MARK: Helper

extension UIView {
    func addSubviewWithEqualAnchors(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension UIViewController {
    func add(_ child: UIViewController, in containerView: UIView? = nil, signalLifecycle signal: Bool = false, appearanceDelay delay: TimeInterval = 0) {
        let container = containerView ?? view
        
        addChild(child)
        child.view.frame = container?.bounds ?? .zero
        if signal {
            child.beginAppearanceTransition(true, animated: true)
        }
        container?.addSubviewWithEqualAnchors(child.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if signal {
                child.endAppearanceTransition()
            }
            child.didMove(toParent: self)
        }
    }
}

#Preview {
    ViewController()
}
