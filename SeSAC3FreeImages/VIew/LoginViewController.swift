//
//  LoginViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        viewModel.id.bind { [weak self] text in
            self?.idTextField.text = text
        }
        
        viewModel.pw.bind { [weak self] text in
            self?.pwTextField.text = text
        }
        
        viewModel.isValid.bind { [weak self] bool in
            self?.loginButton.isEnabled = bool
            self?.loginButton.backgroundColor = bool ? .systemBlue : .lightGray
            
            if bool {
                self?.loginButton.backgroundColor = .systemBlue
                self?.loginButton.setTitleColor(.white, for: .normal)
            } else {
                self?.loginButton.backgroundColor = .gray
                self?.loginButton.setTitleColor(.white, for: .normal)
            }
            
        }
    }
    
    @objc
    private func idTextFieldChanged() {
        guard let text = idTextField.text else { return }
        viewModel.id.value = text
        viewModel.checkValidation()
    }
    
    @objc
    private func pwTextFieldChanged() {
        guard let text = pwTextField.text else { return }
        viewModel.pw.value = text
        viewModel.checkValidation()
    }
    
    
    @objc
    private func loginButtonClicked() {
        guard let id = idTextField.text else { return }
        guard let pw = pwTextField.text else { return }
        
        viewModel.signIn {
            print("Login Success -> Alert 띄우기")
        }
    }
}
