//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import Combine
import UIKit

class BMIViewController: UIViewController {
    
    private let rootView = BMIView()
    private let viewModel = BMIViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
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
        let heightTextInput = rootView.heightTextField.text!
        let weightTextInput = rootView.weightTextField.text!
        viewModel.resultButtonTapped.send((heightTextInput, weightTextInput))
    }
    
    private func setupSubscriptions() {
        viewModel.bmiResultOutput.sink { [weak self] bmiResultString in
            self?.rootView.resultLabel.text = bmiResultString
        }.store(in: &cancellables)
    }
    
}
