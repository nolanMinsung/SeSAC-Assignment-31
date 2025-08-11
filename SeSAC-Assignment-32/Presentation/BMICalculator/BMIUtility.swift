//
//  BMIUtility.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Foundation

/// BMI 연산을 담당.
enum BMIUtility {
    
    /// BMI 등급.
    enum BMIGrade: String {
        case underWeight = "저체중"
        case normal = "정상 체중"
        case overweight = "과체중"
        case obesityClass1 = "경도 비만"
        case obesityClass2 = "중경도 비만"
        case obesityClass3 = "고도 비만"
    }
    
    /// BMI 계산 시 발생할 수 있는 에러.
    enum BMIError: Error {
        case invalidHeight
        case invalidWeight
        case emptyHeightInput
        case emptyWeightInput
        case notANumber
    }
    
    static var validHeightRange: ClosedRange<Double> { 130...200 }
    static var validWeightRange: ClosedRange<Double> { 30...140 }
    
    /// BMI를 계산하는 함수.
    /// - Parameters:
    ///   - height: 키(cm)
    ///   - weight: 몸무게(kg)
    /// - Returns: BMI 지수. `Double` 타입
    static func calculateBMI(height: Double, weight: Double) throws(BMIError) -> Double {
        guard validHeightRange.contains(height) else {
            throw BMIError.invalidHeight
        }
        
        guard validWeightRange.contains(weight) else {
            throw BMIError.invalidWeight
        }
        
        return weight / pow(height/100, 2)
    }
    
    /// BMI 등급을 분류하는 함수.
    /// - Parameters:
    ///   - bmi: BMI 지수
    static func gradeBMIStatus(_ bmi: Double) -> BMIGrade  {
        switch bmi {
        case ..<18:
            return .underWeight
        case 18.5..<25:
            return .normal
        case 25..<30:
            return .overweight
        case 30..<35:
            return .obesityClass1
        case 35..<40:
            return .obesityClass2
        default:
            return .obesityClass3
        }
    }
    
    static func getBMIResult(heightInput: String, weightInput: String) -> String {
        let message: String
        
        do throws (BMIError) {
            // 입력값 추출
            let heightInput = heightInput.trimmingCharacters(in: .whitespacesAndNewlines)
            let weightInput = weightInput.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // 입력값이 비었있는지 확인
            // 입력값이 비어있는 경우는 에러처리를 하기보다, 값이 비어있을 때 버튼을 비활성화하도록 구현하는 방법도 좋을 듯.(반응형)
            guard !heightInput.isEmpty else { throw BMIError.emptyHeightInput }
            guard !weightInput.isEmpty else { throw BMIError.emptyWeightInput }
            
            // 숫자 여부 확인
            guard let height = Double(heightInput),
                  let weight = Double(weightInput) else {
                throw BMIError.notANumber
            }
            
            // bmi 계산
            let bmi = try calculateBMI(height: height, weight: weight)
            let bmiGrade = gradeBMIStatus(bmi)
            message = "결과: \(bmiGrade.rawValue)입니다."
            
        } catch let bmiError {
            switch bmiError {
            case .invalidHeight:
                message = "유효한 범위의 키를 입력해 주세요: \(validHeightRange.lowerBound) 이상 \(validHeightRange.upperBound)이하"
            case .invalidWeight:
                message = "유효한 범위의 몸무게를 입력해 주세요: \(validWeightRange.lowerBound) 이상 \(validWeightRange.upperBound)이하"
            case .emptyHeightInput:
                message = "키 입력 란이 비어있습니다. \n키 값을 입력해 주세요."
            case .emptyWeightInput:
                message = "몸무게 입력 란이 비어있습니다. \n몸무게 값을 입력해 주세요."
            case .notANumber:
                message = "숫자만 입력해 주세요."
            }
            
        }
        return message
    }
    
}
