//
//  AgeViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/9/25.
//

import Foundation

class AgeViewModel {
    
    let resultButtonTapped = MSSubject(value: "")
    
    let ageCalculationOutput = MSSubject(value: 0)
    let ageCalculationError = MSSubject<AgeValidationUtility.AgeValidationError>(value: .emptyInput)
    
    init() {
        resultButtonTapped.subscribe { [weak self] inputValue in
            guard let self else { return }
            do throws(AgeValidationUtility.AgeValidationError) {
                let validAge = try AgeValidationUtility.getValidAgeInput(input: inputValue)
                self.ageCalculationOutput.value = validAge
            } catch {
                self.ageCalculationError.value = error
            }
        }
    }
    
}
