//
//  TransmitterSetupViewController.swift
//  CGMBLEKitUI
//
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import UIKit
import LoopKit
import LoopKitUI
import CGMBLEKit
import ShareClient

class TransmitterSetupViewController: UINavigationController, CGMManagerSetupViewController, UINavigationControllerDelegate {
    class func instantiateFromStoryboard() -> TransmitterSetupViewController {
        return UIStoryboard(name: "TransmitterManagerSetup", bundle: Bundle(for: TransmitterSetupViewController.self)).instantiateInitialViewController() as! TransmitterSetupViewController
    }

    weak var setupDelegate: CGMManagerSetupViewControllerDelegate?

    var cgmManagerType: TransmitterManager.Type!

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        view.backgroundColor = .white
        navigationBar.shadowImage = UIImage()
    }

    func completeSetup(state: TransmitterManagerState) {
        if let manager = cgmManagerType.init(state: state) as? CGMManagerUI {
            setupDelegate?.cgmManagerSetupViewController(self, didSetUpCGMManager: manager)
        }
    }

    // MARK: - UINavigationControllerDelegate

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Read state values
        let viewControllers = navigationController.viewControllers
        let count = navigationController.viewControllers.count

        if count >= 2 {
            switch viewControllers[count - 2] {
            case _ as TransmitterIDSetupViewController:
                break
            default:
                break
            }
        }

        // Set state values
        switch viewController {
        case _ as TransmitterIDSetupViewController:
            break
        default:
            break
        }

        // Adjust the appearance for the main setup view controllers only
        if viewController is SetupTableViewController {
            navigationBar.isTranslucent = false
            navigationBar.shadowImage = UIImage()
        } else {
            navigationBar.isTranslucent = true
            navigationBar.shadowImage = nil
            viewController.navigationItem.largeTitleDisplayMode = .never
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        // Adjust the appearance for the main setup view controllers only
        if viewController is SetupTableViewController {
            navigationBar.isTranslucent = false
            navigationBar.shadowImage = UIImage()
        } else {
            navigationBar.isTranslucent = true
            navigationBar.shadowImage = nil
        }
    }
}
