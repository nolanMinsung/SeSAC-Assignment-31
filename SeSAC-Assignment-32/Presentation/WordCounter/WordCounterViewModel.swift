//
//  WordCounterViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/11/25.
//

import Combine
import Foundation

final class WordCounterViewModel {
    
    let textViewDidChange = PassthroughSubject<String, Never>()
    
    private let textViewTextCountOutputSubject = PassthroughSubject<Int, Never>()
    var textViewTextCountOutput: AnyPublisher<Int, Never> {
        textViewTextCountOutputSubject.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        textViewDidChange.sink { [weak self] currentString in
            self?.textViewTextCountOutputSubject.send(currentString.count)
        }.store(in: &cancellables)
    }
    
}
