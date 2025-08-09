//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

class AgeViewController: UIViewController {
    
    let rootView = AgeView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let validAge: Int = try getValidAgeInput(input: rootView.textField.text!)
            rootView.label.text = "당신의 나이는 \(validAge)입니다."
        } catch {
            rootView.label.text = error.localizedDescription
        }
        
    }
}


// MARK: - Input Validation
extension AgeViewController {
    
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
    
    func getValidAgeInput(input: String) throws(AgeValidationError) -> Int {
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
