//
//  ViewController.swift
//  BusForYo
//
//  Created by Stepan on 26.09.2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    var animationView: LottieAnimationView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        animationView = LottieAnimationView(name: "splash_anim")
        guard let animationView else {return}
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        animationView.play { [weak self] finished in
            if finished {
                self?.goToNextScreen()
            }
        }
    }
    
    func goToNextScreen() {
        
        if let _ = UserDefaults.standard.string(forKey: "currentUser") {
            let mainVC = MainViewController()
            navigationController?.setViewControllers([mainVC], animated: true)
        } else {
            let authVC = AuthViewController()
            navigationController?.setViewControllers([authVC], animated: true)
        }
    }
    
}
