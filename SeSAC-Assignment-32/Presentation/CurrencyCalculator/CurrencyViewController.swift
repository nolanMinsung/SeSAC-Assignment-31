//
//  CurrencyViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

class CurrencyViewController: UIViewController {
    
    private let rootView = CurrencyView()
    private let viewModel = CurrencyViewModel()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActions()
        setupSubscriptions()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func setupActions() {
        rootView.convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
    }
     
    @objc private func convertButtonTapped() {
        viewModel.convertButtonTapped.value = rootView.amountTextField.text!
    }
    
    private func setupSubscriptions() {
        viewModel.convertOutput.subscribe { [weak self] convertedAmount in
            self?.rootView.resultLabel.text = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        }
        viewModel.convertError.subscribe { [weak self] error in
            self?.rootView.resultLabel.text = error.localizedDescription
        }
    }
    
}
