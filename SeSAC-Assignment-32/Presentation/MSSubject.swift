//
//  MSSubject.swift
//  SeSAC-Assignment-32
//
//  Created by 김민성 on 8/11/25.
//

import Foundation


final class MSSubject<Element> {
    
    private var action: ((Element) -> Void)?
    
    var value: Element {
        didSet {
            action?(value)
        }
    }
    
    init(value: Element) {
        self.value = value
    }
    
    func subscribe(action: @escaping (Element) -> Void) {
        // 값 할당 시 실행할 동작 정의
        self.action = action
        // 처음 구독 직후에 한 번 동작 실행.
        self.action?(value)
    }
}
