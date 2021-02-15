//
//  LoginViewController.swift
//  instasham
//
//  Created by Benjamin Tincher on 2/13/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct  Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return  field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return  button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "gradient"))
        header.addSubview(backgroundImageView)
        
        return header
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Create New Account", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //  assign frames
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height * 0.4)
        usernameEmailField.frame = CGRect(x: 24.0, y: headerView.bottom + 40, width: view.width - 48, height: 48)
        passwordField.frame = CGRect(x: 24, y: usernameEmailField.bottom + 8, width: view.width - 48, height: 48)
        loginButton.frame = CGRect(x: 24, y: passwordField.bottom + 8, width: view.width - 48, height: 48)
        createAccountButton.frame = CGRect(x: 24, y: loginButton.bottom + 8, width: view.width - 48, height: 48)
        
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        
        let label = UILabel()
        headerView.addSubview(label)
        label.text = "Instasham"
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.textColor = .white
        label.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: headerView.width, height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(headerView)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButton() {}

    @objc private func didTapTermsButton() {}
    
    @objc private func didTapPrivacyButton() {}
    
    @objc private func didTapCreateAccountButton() {}
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}
