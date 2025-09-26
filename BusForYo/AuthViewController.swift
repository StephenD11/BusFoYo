//
//  AuthViewController.swift
//  BusForYo
//
//  Created by Stepan on 26.09.2025.
//

import UIKit

class AuthViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Main_Logo")
        return iv
    }()
    
    lazy var topLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Welcome to BusForYo"
        lb.textColor = .darkGray
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
        
    }()
    
    lazy var enterButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemYellow
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        
        config.attributedTitle = AttributedString("Enter", attributes: AttributeContainer([
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]))
        
        btn.configuration = config
        btn.addTarget(self, action: #selector(enterTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var registrationButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemYellow
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString("Registration", attributes: AttributeContainer([
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]))
        
        btn.configuration = config
        btn.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var usernameTextField: UITextField = {
       let um = UITextField()
        um.translatesAutoresizingMaskIntoConstraints = false
        um.placeholder = "Username"
        um.borderStyle = .roundedRect
        um.autocapitalizationType = .none
        return um
    }()
    
    lazy var passwordTextField: UITextField = {
       let pass = UITextField()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.placeholder = "Password"
        pass.borderStyle = .roundedRect
        pass.isSecureTextEntry = true
        return pass
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let testUser: [String: String] = ["username": "test", "password": "1234"]
        UserDefaults.standard.set([testUser], forKey: "users")
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(enterButton)
        view.addSubview(registrationButton)
        view.addSubview(topLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            topLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            usernameTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 150),
            enterButton.heightAnchor.constraint(equalToConstant: 40),
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),

            registrationButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.widthAnchor.constraint(equalToConstant: 150),
            registrationButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private struct DefaultsKeys {
        static let users = "users"
        static let currentUser = "currentUser"
    }
    
    func fetchusers() -> [[String:String]] {
        let users = UserDefaults.standard.array(forKey: DefaultsKeys.users) as? [[String:String]] ?? []
        return users
    }
    
    func saveUsers(_ users: [[String:String]]) {
        UserDefaults.standard.set(users, forKey: DefaultsKeys.users)
    }
    
    func findUser(username: String, password: String) -> [String:String]? {
        let users = fetchusers()
        return users.first { $0["username"] == username && $0["password"] == password}
    }
    
    func setCurrentUser(_ username: String) {
        UserDefaults.standard.set(username, forKey: DefaultsKeys.currentUser)
    }
    
    
    func goToMainScreen() {
        let mainVC = MainViewController() // Создаем экземпляр главного экрана
        navigationController?.setViewControllers([mainVC], animated: true) // Устанавливаем главный экран как единственный в стеке навигации, чтобы убрать кнопку "Back"
    }
    
    @objc func enterTapped() {
        
        view.endEditing(true)
        
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
            let alert = UIAlertController(title:"Erorr", message: "Enter Login or Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert,animated: true)
            return
        }
        
        if findUser(username: username, password: password) != nil {
            setCurrentUser(username)
            goToMainScreen()
        } else {
            let alert = UIAlertController(title: "User not found ❌", message: "Account with Username and password not found. Try again or registrate new account", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
                self.usernameTextField.becomeFirstResponder()
            }))
            
            alert.addAction(UIAlertAction(title: "Registration", style: .default, handler: {_ in
                self.registrationTapped()
            }))
            
            
            present(alert, animated: true)
        }
              

    }
    
    
    @objc func registrationTapped() {
        view.endEditing(true)
        let regVC = RegViewController()
        navigationController?.pushViewController(regVC, animated: true) 
    }
    
}
