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
        tv.isEditable = false
        tv.backgroundColor = .idusOrange
        return tv
    }()
    let expandableButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("펼치기", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.tag = 0
        return btn
    }()
    var basicHeight: NSLayoutConstraint?
    var expandedHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicHeight = textView.heightAnchor.constraint(equalToConstant: 100)
        expandedHeight = textView.heightAnchor.constraint(equalToConstant: 200)
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
        basicHeight?.isActive = true
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
            self.basicHeight?.isActive = false
            self.expandedHeight?.isActive = true
        case .expand:
            self.expandedHeight?.isActive = false
            self.basicHeight?.isActive = true
        }
    }
}
