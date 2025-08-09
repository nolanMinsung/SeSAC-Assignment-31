//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let validAge: Int = try getValidAgeInput(input: textField.text!)
            label.text = "당신의 나이는 \(validAge)입니다."
        } catch {
            label.text = error.localizedDescription
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
