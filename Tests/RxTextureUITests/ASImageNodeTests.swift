//
//  ASImageNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift
import RxTextureUI
import XCTest

internal final class ASImageNodeTests: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASImageNode!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASImageNode()
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    // MARK: - Test Cases
    
    internal func testBindImage_shouldMutate() {
        Observable<UIImage?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image, nil)
        
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image, UIImage.mockRed)
        
        Observable<UIImage>.just(.mockBlue)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image, UIImage.mockBlue)
    }
}
