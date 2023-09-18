//
//  NumberViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/18.
//

import UIKit

final class NumberViewController: UIViewController {

    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!

    private let viewModel = NumberViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }

    func bindData() {
        viewModel.number.bind { [weak self] koreanWon in
            self?.numberTextField.text = koreanWon
        }

        viewModel.result.bind { [weak self] value in
            self?.resultLabel.text = value
        }
    }

    @objc
    private func numberTextFieldChanged() {
        viewModel.number.value = numberTextField.text // VM에 내용을 전달해야 한다
        viewModel.convertNumber()
    }
}
