//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import Combine
import UIKit

class AgeViewController: UIViewController {
    
    private let rootView = AgeView()
    private let viewModel = AgeViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        viewModel.resultButtonTapped.send(rootView.textField.text!)
    }
    
    /// viewModel의 ouput 이벤트를 구독
    private func setupSubscriptions() {
        viewModel.ageCalculationOutPut.sink { [weak self] validAge in
            self?.rootView.label.text = "당신의 나이는 \(validAge)입니다."
        }.store(in: &cancellables)
        
        viewModel.ageCalculationError.sink { [weak self] ageValidationError in
            self?.rootView.label.text = ageValidationError.localizedDescription
        }.store(in: &cancellables)
    }
    
}
