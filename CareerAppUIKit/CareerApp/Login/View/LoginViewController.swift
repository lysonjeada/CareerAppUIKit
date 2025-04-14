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

final class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    
    // MARK: - UI Components
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.title
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .persianBlue
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.subtitle
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.emailLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = LoginStrings.emailPlaceholder
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.passwordLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = LoginStrings.passwordPlaceholder
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.loginButton, for: .normal)
        button.backgroundColor = .persianBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var loginWithoutCredentialsButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.loginWithoutCredentials, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.persianBlue.cgColor
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.forgotPassword, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.signup, for: .normal)
        button.setTitleColor(.persianBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    // MARK: - Initializers
    init(interactor: LoginBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupActions()
    }

    // MARK: - Actions
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

    // MARK: - Display Logic
    func showLoginSuccess() {
        interactor?.routeToArticles()
    }

    func showLoginError(_ message: String) {
        showAlert(title: LoginStrings.errorTitle, message: message)
    }

    // MARK: - Alert Helper
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: LoginStrings.okButton, style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Setup Views
private extension LoginViewController {
    func setupViews() {
        view.backgroundColor = .white

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
    }

    func setupConstraints() {
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
            loginWithoutCredentialsButton.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20)
        ])
    }

    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginWithoutCredentialsButton.addTarget(self, action: #selector(loginWithoutCredentialsTapped), for: .touchUpInside)
    }
}
