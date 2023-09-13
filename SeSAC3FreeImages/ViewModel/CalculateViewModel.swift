//
//  CalculateViewModel.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/13.
//

import Foundation

class CalculateViewModel {
    
    var firstNumber: CustomObservable<String?> = CustomObservable("3")
    var secondNumber: CustomObservable<String?> = CustomObservable("8")
    var resultText = CustomObservable("result is 30")
    var numberText = CustomObservable("Text for test")
    
    func presentNumberFormat() {
        guard let firstNumber = firstNumber.value,
              let firstConvertedNumber = Int(firstNumber)
        else {
            resultText.value = "cannot convert to number"
            return
        }
        
        numberText.value = format(for: firstConvertedNumber)
    }
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func calculate() {
        guard let firstNumber = firstNumber.value,
              let firstConvertedNumber = Int(firstNumber)
        else {
            resultText.value = "first value error"
            return
        }
        
        guard let secondNumber = secondNumber.value,
              let secondConvertedNumber = Int(secondNumber)
        else {
            resultText.value = "second value error"
            return
            
        }
        
        resultText.value = "result is \(firstConvertedNumber + secondConvertedNumber)"
        
    }
}
