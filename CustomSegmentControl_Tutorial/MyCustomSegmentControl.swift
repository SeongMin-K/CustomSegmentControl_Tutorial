//
//  MyCustomSegmentControl.swift
//  CustomSegmentControl_Tutorial
//
//  Created by SeongMinK on 2021/10/14.
//

import Foundation
import UIKit

protocol MyCustomSegmentControlDelegate: AnyObject {
    // 아이템이 선택됨
    func segmentValueChanged(to index: Int)
}

class MyCustomSegmentControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    var textColor: UIColor = .black
    var selectedColor: UIColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    public private(set) var selectedIndex: Int = 0
    weak var mySegmentDelegate: MyCustomSegmentControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 기본적인 뷰 설정
    }
    
    // 데이터를 뷰에 적용할 때
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        print(#fileID, #function, "called")
        
        self.buttonTitles =  buttonTitles
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(#fileID, #function, "called")
        
        updateView()
    }
    
    fileprivate func updateView() {
        print(#fileID, #function, "called")
        
        // 버튼 만들기
        createBtn()
        // 스택 뷰 설정
        configStackView()
    }
    
    fileprivate func createBtn() {
        print(#fileID, #function, "called")
        
        self.buttons = [UIButton]()
        // 기존 버튼 다 지우기
        self.buttons.removeAll()
        // 하위 뷰들 다 지우기
        self.subviews.forEach({$0.removeFromSuperview()})
        for buttonTitleItem in buttonTitles {
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.titleLabel?.textColor = .black
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            button.layer.cornerRadius = 20
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.setTitle(buttonTitleItem, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(MyCustomSegmentControl.buttonAction(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        // 선택된 버튼 설정
        buttons[0].setTitleColor(.white, for: .normal)
        buttons[0].backgroundColor = selectedColor
        
    }
    
    // 스택 뷰 설정
    fileprivate func configStackView() {
        print(#fileID, #function, "called")
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    // 세그먼트 버튼이 선택되었을 때
    @objc func buttonAction(_ sender: UIButton) {
        for(buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                self.selectedIndex = buttonIndex
                mySegmentDelegate?.segmentValueChanged(to: self.selectedIndex)
                btn.backgroundColor = selectedColor
                btn.setTitleColor(.white, for: .normal)
            } else {
                btn.backgroundColor = .white
                btn.setTitleColor(textColor, for: .normal)
            }
        }
        print(#fileID, #function, "called / selectedIndex: \(self.selectedIndex)")
    }
}

// Preview
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
func updateUIViewController(_ uiViewController: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
}
@available(iOS 13.0, *)
struct MyTestViewControllerPreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .previewDevice("iPhone 12 Pro")
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif
