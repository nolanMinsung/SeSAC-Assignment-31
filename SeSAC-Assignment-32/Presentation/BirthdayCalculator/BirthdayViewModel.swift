//
//  BirthdayViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

class BirthdayViewModel {
    
    let resultButtonTapped: MSSubject<(String, String, String)> = .init(value: ("", "", ""))
    
    let birthdayCountOutput: MSSubject<Result<Int, BirthdayCalculationUtility.BirthdayValidationError>>
    = .init(value: .failure(.notANumber))
    
    init() {
        resultButtonTapped.subscribe { [weak self] year, month, day in
            do throws(BirthdayCalculationUtility.BirthdayValidationError) {
                let daysUntilBirthday = try BirthdayCalculationUtility.daysUntilBirthday(year: year, month: month, day: day)
                self?.birthdayCountOutput.value = .success(daysUntilBirthday)
            } catch {
                print("!!!!!!에러 발생!!!!!")
                print(error.localizedDescription)
                self?.birthdayCountOutput.value = .failure(error)
            }
        }
    }
    
}
