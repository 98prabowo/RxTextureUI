//
//  ASButtonNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.
//

import RxCocoa
import RxSwift
import TextureSwiftSupport
import XCTest

@testable import RxTextureUI

internal final class ASButtonNodeTests: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASButtonNode!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASButtonNode()
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    // MARK: - Attributed Text Tests
    
    internal func testSuccessBindAttributeText_onAllState() {
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedApple)
        
        Observable<NSAttributedString>.just(.mockAttributedOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedOrange)
    }
    
    internal func testSuccessBindAttributeText_onNormalState() {
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(.normal))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeText_onHighlightedState() {
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(.highlighted))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeText_onDiabledState() {
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(.disabled))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeText_onSelectedState() {
        Observable<NSAttributedString>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(.selected))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeOnText_onNormalState() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(nil, for: .normal))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeOnText_onHighlightedState() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(nil, for: .highlighted))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeOnText_onDisabledState() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(nil, for: .disabled))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeOnText_onSelectedState() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText(nil, for: .selected))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedApple)
    }
    
    internal func testSuccessBindAttributeText_onAllASControlStateType() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(
                sut.rx.attributedText(
                    applyList: [
                        .normal(nil),
                        .highlighted(nil),
                        .disabled(nil),
                        .selected(nil)
                    ]
                )
            )
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedApple)
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedApple)
        
        Observable<String>.just(.mockOrange)
            .asDriverOnErrorJustComplete()
            .drive(
                sut.rx.attributedText(
                    applyList: [
                        .normal(nil),
                        .highlighted(nil),
                        .disabled(nil),
                        .selected(nil)
                    ]
                )
            )
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .disabled), NSAttributedString.mockAttributedOrange)
        XCTAssertEqual(sut.attributedTitle(for: .selected), NSAttributedString.mockAttributedOrange)
    }
    
    internal func testSuccessBindText_onAllState() {
        Observable<String>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal)?.string, String.mockApple)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted)?.string, String.mockApple)
        XCTAssertEqual(sut.attributedTitle(for: .disabled)?.string, String.mockApple)
        XCTAssertEqual(sut.attributedTitle(for: .selected)?.string, String.mockApple)
        
        Observable<String>.just(.mockOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedTitle(for: .normal)?.string, String.mockOrange)
        XCTAssertEqual(sut.attributedTitle(for: .highlighted)?.string, String.mockOrange)
        XCTAssertEqual(sut.attributedTitle(for: .disabled)?.string, String.mockOrange)
        XCTAssertEqual(sut.attributedTitle(for: .selected)?.string, String.mockOrange)
    }
    
    // MARK: - Image Tests
    
    internal func testbindImage_onAllState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .normal), UIImage.mockRed)
        XCTAssertEqual(sut.image(for: .highlighted), UIImage.mockRed)
        XCTAssertEqual(sut.image(for: .disabled), UIImage.mockRed)
        XCTAssertEqual(sut.image(for: .selected), UIImage.mockRed)
        
        Observable<UIImage>.just(.mockBlue)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .normal), UIImage.mockBlue)
        XCTAssertEqual(sut.image(for: .highlighted), UIImage.mockBlue)
        XCTAssertEqual(sut.image(for: .disabled), UIImage.mockBlue)
        XCTAssertEqual(sut.image(for: .selected), UIImage.mockBlue)
    }
    
    internal func testBindImage_onNormalState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image(applyList: [.normal(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .normal), UIImage.mockRed)
    }
    
    internal func testBindImage_onHighlightedState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image(applyList: [.highlighted(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .highlighted), UIImage.mockRed)
    }
    
    internal func testBindImage_onDisabledState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image(applyList: [.disabled(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .disabled), UIImage.mockRed)
    }
    
    internal func testBindImage_onSelectedState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.image(applyList: [.selected(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.image(for: .selected), UIImage.mockRed)
    }
    
    // MARK: - Background Image Tests
    
    internal func testBindBackgroundImage_onAllState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .normal), UIImage.mockRed)
        XCTAssertEqual(sut.backgroundImage(for: .highlighted), UIImage.mockRed)
        XCTAssertEqual(sut.backgroundImage(for: .disabled), UIImage.mockRed)
        XCTAssertEqual(sut.backgroundImage(for: .selected), UIImage.mockRed)
        
        Observable<UIImage>.just(.mockBlue)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .normal), UIImage.mockBlue)
        XCTAssertEqual(sut.backgroundImage(for: .highlighted), UIImage.mockBlue)
        XCTAssertEqual(sut.backgroundImage(for: .disabled), UIImage.mockBlue)
        XCTAssertEqual(sut.backgroundImage(for: .selected), UIImage.mockBlue)
    }
    
    internal func testBindBackgroundImage_onNormalState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage(applyList: [.normal(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .normal), UIImage.mockRed)
    }
    
    internal func testBindBackgroundImage_onHighlightedState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage(applyList: [.highlighted(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .highlighted), UIImage.mockRed)
    }
    
    internal func testBindBackgroundImage_onDisabledState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage(applyList: [.disabled(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .disabled), UIImage.mockRed)
    }
    
    internal func testBindBackgroundImage_onSelectedState() {
        Observable<UIImage>.just(.mockRed)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.backgroundImage(applyList: [.selected(nil)]))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.backgroundImage(for: .selected), UIImage.mockRed)
    }
    
}
