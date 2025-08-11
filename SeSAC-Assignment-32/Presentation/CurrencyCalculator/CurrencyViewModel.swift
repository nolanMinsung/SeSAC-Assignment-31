//
//  CurrencyViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/11/25.
//

import Foundation

final class CurrencyViewModel {
    
    enum CurrencyError: LocalizedError {
        case emptyInput
        case notANumber
        
        var errorDescription: String? {
            switch self {
            case .emptyInput:
                return "입력값이 비어있습니다."
            case .notANumber:
                return "올바른 금액을 입력해주세요"
            }
        }
    }
    
    let convertButtonTapped = MSSubject<String>(value: "")
    
    let convertOutput = MSSubject<Double>(value: 0.0)
    let convertError = MSSubject<CurrencyError>(value: .emptyInput)
    
    init() {
        convertButtonTapped.subscribe { [weak self] inputValue in
            guard !inputValue.isEmpty else {
                self?.convertError.value = .emptyInput
                return
            }
            guard let amount = Double(inputValue) else {
                self?.convertError.value = .notANumber
                return
            }
            
            let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
            let convertedAmount = amount / exchangeRate
            self?.convertOutput.value = convertedAmount
        }
    }
    
}
