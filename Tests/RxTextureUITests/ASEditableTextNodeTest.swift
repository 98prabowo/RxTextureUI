//
//  ASEditableTextNodeTest.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import RxCocoa
import RxSwift
import TextureSwiftSupport
import XCTest

@testable import RxTextureUI

internal final class ASEditableTextNodeTest: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASEditableTextNode!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASEditableTextNode()
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    // MARK: - Test Cases
    
    internal func testBindAttributedText_shouldMutate() {
        Observable<NSAttributedString?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, nil)
        
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, String.mockApple)
        
        Observable<NSAttributedString>.just(.mockAttributedOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, String.mockOrange)
    }
    
    internal func testBindText_shouldMutate() {
        Observable<String?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, nil)
        
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, String.mockApple)
        
        Observable<String>.just(.mockOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, String.mockOrange)
    }
}
