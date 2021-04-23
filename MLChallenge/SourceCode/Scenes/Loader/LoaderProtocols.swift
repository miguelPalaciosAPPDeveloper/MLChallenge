//
//  LoaderProtocols.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import UIKit

protocol LoaderPresentable {
    func presentLoader(completion: (() -> Void)?)
    
    func dismissLoader(completion: (() -> Void)?)
}

// MARK: - Loader extension for viewControllers
extension LoaderPresentable where Self: UIViewController {
    func presentLoader(completion: (() -> Void)?) {
        let loader = LoaderViewController(animation: "loader")
        self.present(loader, animated: true, completion: completion)
    }
    
    func dismissLoader(completion: (() -> Void)?) {
        DispatchQueue.main.async { [weak self] in
          guard let self = self,
            let presentedViewController = self.presentedViewController,
            presentedViewController is LoaderViewController else {
              completion?()
              return
          }
          presentedViewController.dismiss(animated: true, completion: completion)
        }
    }
}
