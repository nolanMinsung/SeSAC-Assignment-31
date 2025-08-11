//
//  BirthdayViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Combine

class BirthdayViewModel {
    
    // Input Stream
    let resultButtonTapped: PassthroughSubject<(String, String, String), Never> = .init()
    
    // Output Stream
    
    // Age, Birthday와는 조금 다르게, 결괏값, 에러를 Result에 담아 한번에 보냄.
    private let birthdayCountingOutputSubject = PassthroughSubject<Result<Int, Error>, Never>()
    var birthdayCountingOutput: AnyPublisher<Result<Int, Error>, Never> {
        return birthdayCountingOutputSubject.eraseToAnyPublisher()
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        resultButtonTapped.sink { [weak self] year, month, day in
            do throws(BirthdayCalculationUtility.BirthdayValidationError) {
                let daysUntilBirthday = try BirthdayCalculationUtility.daysUntilBirthday(year: year, month: month, day: day)
                self?.birthdayCountingOutputSubject.send(.success(daysUntilBirthday))
            } catch {
                print("!!!!!!에러 발생!!!!!")
                print(error.localizedDescription)
                self?.birthdayCountingOutputSubject.send(.failure(error))
            }
        }.store(in: &cancellables)
        
    }
    
}
