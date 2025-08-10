//
//  BMIViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Combine
import Foundation

class BMIViewModel {
    
    // Input Stream
    
    // (height, weight) 입력값 문자열 전달
    let resultButtonTapped = PassthroughSubject<(String, String), Never>()
    
    // Output Stream
    
    // Age와는 다르게 Error 발생 시의 메시지도 다 String으로 추합하여 하나의 스트림으로 전달해 보았음.
    private let bmiResultOutputSubjet = PassthroughSubject<String, Never>()
    var bmiResultOutput: AnyPublisher<String, Never> {
        return bmiResultOutputSubjet.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        resultButtonTapped.sink { [weak self] (heightInput, weightInput) in
            let resultMessage = BMIUtility.getBMIResult(heightInput: heightInput, weightInput: weightInput)
            self?.bmiResultOutputSubjet.send(resultMessage)
        }.store(in: &cancellables)
    }
    
}
