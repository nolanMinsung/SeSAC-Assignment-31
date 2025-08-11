//
//  WordCounterViewModel.swift
//  SeSAC-Assignment-31
//
//  Created by 김민성 on 8/11/25.
//

import Foundation

final class WordCounterViewModel {
    
    let textViewDidChange = MSSubject<String>(value: "")
    
    let textViewTextCountOutput = MSSubject<Int>(value: 0)
    
    init() {
        textViewDidChange.subscribe { [weak self] currentString in
            self?.textViewTextCountOutput.value = currentString.count
        }
    }
    
}
