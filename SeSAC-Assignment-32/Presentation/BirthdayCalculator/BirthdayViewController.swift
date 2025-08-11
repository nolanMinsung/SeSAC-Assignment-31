//
//  BirthdayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

class BirthdayViewController: UIViewController {
    
    private let rootView = BirthdayView()
    private let viewModel = BirthdayViewModel()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        setupSubscriptions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        let yearInput = rootView.yearTextField.text!
        let monthInput = rootView.monthTextField.text!
        let dayInput = rootView.dayTextField.text!
        
        viewModel.resultButtonTapped.value = (yearInput, monthInput, dayInput)
    }
    
    private func setupSubscriptions() {
        viewModel.birthdayCountOutput.subscribe { [weak self] result in
            switch result {
            case .success(let dateDiffToBithday):
                if dateDiffToBithday < 0 {
                    self?.rootView.resultLabel.text = "생일은 오늘부터 \(-dateDiffToBithday)일 전입니다."
                } else if dateDiffToBithday > 0 {
                    self?.rootView.resultLabel.text = "당신의 생일은 오늘부터 \(dateDiffToBithday)일 후입니다."
                } else {
                    self?.rootView.resultLabel.text = "생일축하합니다!"
                }
            case .failure(let error):
                self?.rootView.resultLabel.text = error.localizedDescription
            }
        }
    }
    
}


