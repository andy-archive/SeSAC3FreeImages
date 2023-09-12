//
//  ViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/11.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var changeButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.placeholder = NSLocalizedString("nickname_placeholder", comment: "")
        nicknameTextField.placeholder = "nickname_placeholder".localized
        
        changeButton.setTitle(NSLocalizedString("change_button_title", comment: ""), for: .normal)
        
        let value = NSLocalizedString("nickname_result", comment: "")
        
//        resultLabel.text = String(format: value, "Andy", "콩딱핑")
        resultLabel.text = "age_result".localized(number: 65)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

