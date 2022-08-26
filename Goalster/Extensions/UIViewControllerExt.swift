//
//  UIViewControllerExt.swift
//  Goalster
//
//  Created by Саша Смахтин on 06.07.2022.
//

import UIKit

extension UIViewController {
    
    func presentDetail(viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        // Set animation time
        transition.duration = 0.3
        // Set animation type
        transition.type = CATransitionType.push
        // Set animation move type
        transition.subtype = CATransitionSubtype.fromRight
        // Presenting full screen view
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    
    func presentSecondaryDetail(viewControllerToPresent: UIViewController){
        let transition = CATransition()
        // Set animation time
        transition.duration = 0.3
        // Set animation type
        transition.type = CATransitionType.push
        // Set animation move type
        transition.subtype = CATransitionSubtype.fromRight
        // Presenting full screen view
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        
        
        guard let presentedViewController = presentedViewController else { return }
        dismiss(animated: false, completion: {self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)})
        
    }
    
    
    
    
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    
}
