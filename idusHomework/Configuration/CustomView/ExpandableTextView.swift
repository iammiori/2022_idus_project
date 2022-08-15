//
//  ExpandableTextView.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/15.
//

import UIKit

enum ExpandState {
    case basic
    case expand
}

class ExpandableTextView: UIView {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 17, weight: .regular)
        tv.textContainerInset = .init(top: 0, left: 18, bottom: 0, right: 18)
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainer.maximumNumberOfLines = 3
        return tv
    }()
    let expandableButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("펼치기", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.tag = 0
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [textView, expandableButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            expandableButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -18),
            expandableButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
            expandableButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func changeTextViewHeight(_ state: ExpandState) {
        switch state {
        case .basic:
            textView.textContainer.maximumNumberOfLines = 0
            textView.invalidateIntrinsicContentSize()
        case .expand:
            textView.textContainer.maximumNumberOfLines = 3
            textView.invalidateIntrinsicContentSize()
        }
    }
}
