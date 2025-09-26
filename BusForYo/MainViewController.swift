//
//  MainViewController.swift
//  BusForYo
//
//  Created by Stepan on 26.09.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout",for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        view.addSubview(logoutButton)
        
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func logoutTapped() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
        let authVC = AuthViewController()
        navigationController?.setViewControllers([authVC], animated: true)
    }
}
