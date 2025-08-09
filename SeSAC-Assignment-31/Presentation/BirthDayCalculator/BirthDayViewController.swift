//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

class BirthDayViewController: UIViewController {
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
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
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
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
        
        
        let yearInput = yearTextField.text!
        let monthInput = monthTextField.text!
        let dayInput = dayTextField.text!
        
        
        do throws(BirthDayValidationError) {
            let yearInputNum = try validateYearBounds(input: yearInput)
            let monthInputNum = try validateMonthBounds(input: monthInput)
            let dayInputNum = try validateDayInput(dayInput)
            
            let validDate = try validateInputDates(
                year: yearInputNum,
                month: monthInputNum,
                day: dayInputNum
            )
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let dateString = dateFormatter.string(from: validDate)
            
//            resultLabel.text = "당신의 생일은 \(dateString)입니다."
            resultLabel.text = "당신의 생일은 오늘부터 \(daysFromToday(to: validDate) ?? 0)입니다."
        } catch {
            resultLabel.text = error.localizedDescription
        }
        
    }
}


// MARK: - Validation Birthday Input
private extension BirthDayViewController {
    
    private static var lowerBound: Int { 1900 }
    
    private static var currentYear: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.year], from: .now).year!
    }
    
    private static var currentMonth: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.month], from: .now).month!
    }
    
    enum BirthDayValidationError: LocalizedError {
        case notANumber
        case yearOutOfRange
        case monthOutOfRange
        case dateNotInCalendar(year: Int, month: Int, day: Int)
        
        var errorDescription: String? {
            switch self {
            case .notANumber:
                "입력값 중 하나가 정수가 아닙니다. 모든 입력값을 정수로 입력해 주세요."
            case .yearOutOfRange:
                "유효한 연도 범위를 벗어났습니다. (\(lowerBound) 이상 \(currentYear) 이하)"
            case .monthOutOfRange:
                "유효한 월 범위를 벗어났습니다."
            case .dateNotInCalendar(let year, let month, let day):
                "해당 날짜는 존재하지 않습니다. 입력값: \(year)년 \(month)월 \(day)일"
            }
        }
    }
    
    func validateInputDates(year: Int, month: Int, day: Int) throws(BirthDayValidationError) -> Date  {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar.current
        
        guard let date = calendar.date(from: dateComponents) else {
            // 자동으로 보정해주는 듯...?
            throw .dateNotInCalendar(year: year, month: month, day: day)
        }
        
        return date
    }
    
    func validateYearBounds(input: String) throws(BirthDayValidationError) -> Int {
        let trimmedAndJointInput = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
        
        guard let inputNum = Int(trimmedAndJointInput) else {
            throw .notANumber
        }
        
        guard (Self.lowerBound...Self.currentYear).contains(inputNum) else {
            throw .yearOutOfRange
        }
        
        return inputNum
    }
    
    func validateDayInput(_ input: String) throws(BirthDayValidationError) -> Int {
        let trimmedAndJointInput = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
        
        guard let inputNum = Int(trimmedAndJointInput) else {
            throw .notANumber
        }
        return inputNum
    }
    
    func validateMonthBounds(input: String) throws(BirthDayValidationError) -> Int {
        let trimmedAndJointInput = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
        
        guard let inputNum = Int(trimmedAndJointInput) else {
            throw .notANumber
        }
        
        guard (1...12).contains(inputNum) else {
            throw .monthOutOfRange
        }
        
        return inputNum
    }
    
    func daysFromToday(to date: Date) -> Int? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let targetDate = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        return components.day
    }
    
}


