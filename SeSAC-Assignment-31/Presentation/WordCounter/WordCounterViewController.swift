//
//  WordCounterViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import Combine
import UIKit
import SnapKit
 
class WordCounterViewController: UIViewController {
    
    private let rootView = WordCounterView()
    private let viewModel = WordCounterViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        view = rootView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        setupSubscriptions()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func setupTextView() {
        rootView.textView.delegate = self
    }
    
    private func setupSubscriptions() {
        viewModel.textViewTextCountOutput.sink { [weak self] textCount in
            self?.rootView.countLabel.text = "현재까지 \(textCount)글자 작성중"
        }.store(in: &cancellables)
    }
}
 
extension WordCounterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.textViewDidChange.send(textView.text)
    }
    
}
