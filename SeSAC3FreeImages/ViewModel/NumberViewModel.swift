//
//  NumberViewModel.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/18.
//

import UIKit

class NumberViewModel {

    var number: Observable<String?> = Observable("1000") // numberTextField
    var result = Observable("1,327,000") // resultLabel

    var currencyDollarToWon = 1327

    func convertNumber() {

        guard let text = number.value else {
            result.value = "값을 입력해 주세요"
            return
        }

        guard let textToNumber = Int(text) else {
            result.value = "100만원 이하의 입력해 주세요"
            return
        }

        guard textToNumber > 0, textToNumber <= 1_000_000 else {
            result.value = "환전의 범위는 100만원 이하입니다"
            return
        }

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let decimalNumber = numberFormatter.string(for: textToNumber * currencyDollarToWon) {
            result.value = "₩\(decimalNumber)"
        }
    }
}
