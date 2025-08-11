//
//  BMIViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Foundation

class BMIViewModel {
    
    let resultButtonTapped = MSSubject<(String, String)>(value: ("", ""))
    
    // Age와는 다르게 Error 발생 시의 메시지도 다 String으로 추합하여 하나의 스트림으로 전달해 보았음.
    let bmiResultOutput = MSSubject(value: "")
    
    init() {
        resultButtonTapped.subscribe { [weak self] (heightInput, weightInput) in
            let resultMessage = BMIUtility.getBMIResult(heightInput: heightInput, weightInput: weightInput)
            self?.bmiResultOutput.value = resultMessage
        }
    }
    
}
