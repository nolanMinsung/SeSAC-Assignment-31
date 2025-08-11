//
//  AgeValidationUtility.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Foundation

/// 나이 입력값 검증을 담당.
enum AgeValidationUtility {
    
    enum AgeValidationError: LocalizedError {
        case emptyInput
        case notInteger
        case outOfRange
        
        var errorDescription: String? {
            switch self {
            case .emptyInput:
                "입력값이 비어있습니다."
            case .notInteger:
                "입력값이 정수가 아닙니다."
            case .outOfRange:
                "1세에서 100세까지의 숫자만 입력해 주세요."
            }
        }
    }
    
    static func getValidAgeInput(input: String) throws(AgeValidationError) -> Int {
        let trimmedAndJoinedInput = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
        
        guard !trimmedAndJoinedInput.isEmpty else {
            throw .emptyInput
        }
        guard let age = Int(trimmedAndJoinedInput) else {
            throw .notInteger
        }
        guard (1...100).contains(age) else {
            throw .outOfRange
        }
        return age
    }
    
}
