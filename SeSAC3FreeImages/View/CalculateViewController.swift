//
//  CalculateViewController.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/13.
//

import UIKit

final class CalculateViewController: UIViewController {
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
        }
        
        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
        }
        
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
        viewModel.numberText.bind { text in
            self.numberLabel.text = text
        }
    }
    
    @objc
    private func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }
    
    @objc
    private func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }
}

/*
 super.viewDidLoad()
 
 let person = Person("sesac")
 person.name = "joey"
 
 person.name = "roen"
 person.introduce { value in
     self.resultLabel.text = value
     self.view.backgroundColor = [UIColor.orange, UIColor.systemBlue, UIColor.systemBrown, UIColor.systemGreen].randomElement()!
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     person.name = "tony"
     print("1 seconds later")
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     person.name = "emily"
     print("1 seconds later")
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
     person.name = "willy"
     print("5 seconds later")
 }
 
 person.name = "eddy"
 
 firstTextField.text = viewModel.firstNumber.value
 secondTextField.text = viewModel.secondNumber.value
 */
