//
//  AgeViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/9/25.
//

import Combine
import Foundation

class AgeViewModel {
    
    // Input Stream
    let resultButtonTapped: PassthroughSubject<String, Never> = .init()
    
    // Output Stream
    // 결괏값과 에러를 별도의 스트림으로 나누어 전달.
    
    // 결괏값 스트림
    private let ageCalculationOutPutSubject: PassthroughSubject<Int, Never> = .init()
    var ageCalculationOutPut: AnyPublisher<Int, Never> {
        return ageCalculationOutPutSubject.eraseToAnyPublisher()
    }
    
    // 에러 스트림
    private let ageCalculationErrorSubject: PassthroughSubject<AgeValidationUtility.AgeValidationError, Never> = .init()
    var ageCalculationError: AnyPublisher<AgeValidationUtility.AgeValidationError, Never> {
        return ageCalculationErrorSubject.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        resultButtonTapped.sink { [weak self] inputValue in
            guard let self else { return }
            do throws(AgeValidationUtility.AgeValidationError) {
                let validAge = try AgeValidationUtility.getValidAgeInput(input: inputValue)
                self.ageCalculationOutPutSubject.send(validAge)
            } catch {
                self.ageCalculationErrorSubject.send(error)
            }
        }.store(in: &cancellables)
    }
    
}
