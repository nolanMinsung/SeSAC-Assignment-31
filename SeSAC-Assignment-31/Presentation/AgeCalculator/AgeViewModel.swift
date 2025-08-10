//
//  AgeViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/9/25.
//

import Combine
import Foundation

class AgeViewModel {
    
    let resultButtonTapped: PassthroughSubject<String, Never> = .init()
    
    private let ageCalculationOutPutSubject: PassthroughSubject<Int, Never> = .init()
    var ageCalculationOutPut: AnyPublisher<Int, Never> {
        ageCalculationOutPutSubject.eraseToAnyPublisher()
    }
    
    private let ageCalculationErrorSubject: PassthroughSubject<AgeValidationUtility.AgeValidationError, Never> = .init()
    var ageCalculationError: AnyPublisher<AgeValidationUtility.AgeValidationError, Never> {
        ageCalculationErrorSubject.eraseToAnyPublisher()
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
