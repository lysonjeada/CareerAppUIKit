//
//  LoginViewController.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func showLoginSuccess()
    func showLoginError(_ message: String)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataStore)?
    
    // MARK: UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.title
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .persianBlue
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.subtitle
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.emailLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = LoginStrings.emailPlaceholder
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.passwordLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = LoginStrings.passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.loginButton, for: .normal)
        button.backgroundColor = .persianBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let loginWithoutCredentialsButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.loginWithoutCredentials, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.persianBlue.cgColor
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.forgotPassword, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.signup, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(loginWithoutCredentialsButton)
        
        buttonsStackView.addArrangedSubview(forgotPasswordButton)
        buttonsStackView.addArrangedSubview(signupButton)
        stackView.addArrangedSubview(buttonsStackView)
        
        view.addSubview(stackView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -32),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -20),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -40),
            
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.bottomAnchor.constraint(equalTo: loginWithoutCredentialsButton.topAnchor, constant: -12),
            
            loginWithoutCredentialsButton.heightAnchor.constraint(equalToConstant: 44),
            loginWithoutCredentialsButton.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginWithoutCredentialsButton.addTarget(self, action: #selector(loginWithoutCredentialsTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        let request = Login.Login.Request(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        interactor?.login(request: request)
    }
    
    @objc private func loginWithoutCredentialsTapped() {
        interactor?.loginWithoutCredentials()
    }
    
    func showLoginSuccess() {
        router?.routeToArticles()
    }
    
    func showLoginError(_ message: String) {
        let alert = UIAlertController(title: LoginStrings.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LoginStrings.okButton, style: .default))
        present(alert, animated: true)
    }
}

extension UIColor {
    static var persianBlue: UIColor {
        return UIColor(red: 6/255, green: 71/255, blue: 137/255, alpha: 1.0)
    }
}
