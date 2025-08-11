//
//  BirthdayCalculationUtility.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/10/25.
//

import Foundation


enum BirthdayCalculationUtility {
    
    private static var yearLowerBound: Int { 1900 }
    
    private static var currentYear: Int {
        return Calendar.current.component(.year, from: .now)
    }
    
    enum BirthdayValidationError: LocalizedError {
        case notANumber
        case yearOutOfRange
        case monthOutOfRange
        case dateNotInCalendar(year: Int, month: Int, day: Int)
        case noBirthdayThisYear
        
        var errorDescription: String? {
            switch self {
            case .notANumber:
                "입력값 중 하나가 정수가 아닙니다. 모든 입력값을 정수로 입력해 주세요."
            case .yearOutOfRange:
                "유효한 연도 범위를 벗어났습니다. (\(yearLowerBound) 이상 \(currentYear) 이하)"
            case .monthOutOfRange:
                "유효한 월 범위를 벗어났습니다."
            case .dateNotInCalendar(let year, let month, let day):
                "해당 날짜는 존재하지 않습니다. 입력값: \(year)년 \(month)월 \(day)일"
            case .noBirthdayThisYear:
                "아쉽게도 올해는 생일이 없네요..."
            }
        }
    }
    
    /// 메인 함수: 생년월일로 올해 생일까지 남은 날짜 계산
    static func daysUntilBirthday(year: String, month: String, day: String) throws(BirthdayValidationError) -> Int {
        let (y, m, d) = try parseInputs(year: year, month: month, day: day)
        try validateYearRange(y)
        try validateDate(year: y, month: m, day: d)
        return try calculateDaysUntilBirthday(month: m, day: d)
    }
    
    // MARK: - Parsing & Validation
    
    /// 문자열을 정수로 변환하고 튜플로 반환
    private static func parseInputs(
        year: String,
        month: String,
        day: String
    ) throws(BirthdayValidationError) -> (Int, Int, Int) {
        guard let y = Int(year), let m = Int(month), let d = Int(day) else {
            throw BirthdayValidationError.notANumber
        }
        return (y, m, d)
    }
    
    /// 연도 범위 검증
    private static func validateYearRange(_ year: Int) throws(BirthdayValidationError) {
        guard (yearLowerBound...currentYear).contains(year) else {
            throw BirthdayValidationError.yearOutOfRange
        }
    }
    
    /// 실제 달력에 존재하는 날짜인지 검증
    private static func validateDate(year: Int, month: Int, day: Int) throws(BirthdayValidationError) {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current // otherwise, isValidDate will always return false
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard dateComponents.isValidDate else {
            throw BirthdayValidationError.dateNotInCalendar(year: year, month: month, day: day)
        }
    }
    
    // MARK: - Calculation
    
    /// 올해 생일까지 남은 날짜 계산 (+/-)
    private static func calculateDaysUntilBirthday(month: Int, day: Int) throws(BirthdayValidationError) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let currentYear = calendar.component(.year, from: today)
        
        var dateComponents = DateComponents(year: currentYear, month: month, day: day)
        dateComponents.calendar = calendar
        guard dateComponents.isValidDate, let birthdayThisYear = calendar.date(from:dateComponents) else {
            print("올해 생일이 달력에 없는 듯? ex) 2월 29일")
            throw BirthdayValidationError.noBirthdayThisYear
        }
        
        let diff = calendar.dateComponents([.day], from: today, to: birthdayThisYear).day ?? 0
        return diff
    }
    
}
