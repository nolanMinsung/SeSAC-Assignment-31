//
//  CurrencyViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/11/25.
//

import Combine
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
    
    let convertButtonTapped = PassthroughSubject<String, Never>()
    
    private let convertOutputSubject = PassthroughSubject<Double, Never>()
    private let convertErrorSubject = PassthroughSubject<CurrencyError, Never>()
    
    var convertOutput: AnyPublisher<Double, Never> {
        return convertOutputSubject.eraseToAnyPublisher()
    }
    
    var convertError: AnyPublisher<CurrencyError, Never> {
        return convertErrorSubject.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        convertButtonTapped.sink { [weak self] inputValue in
            guard !inputValue.isEmpty else {
                self?.convertErrorSubject.send(.emptyInput)
                return
            }
            guard let amount = Double(inputValue) else {
                self?.convertErrorSubject.send(.notANumber)
                return
            }
            
            let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
            let convertedAmount = amount / exchangeRate
            self?.convertOutputSubject.send(convertedAmount)
        }.store(in: &cancellables)
    }
    
}
