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
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemGray
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        return lb
    }()
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 17, weight: .regular)
        tv.textContainerInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainer.maximumNumberOfLines = 4
        return tv
    }()
    let expandableButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("펼치기", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.tag = 0
        return btn
    }()
    lazy var titleStackView: UIStackView = {
        let sv = UIStackView()
        [titleLabel, subTitleLabel, textView].forEach { sv.addArrangedSubview($0) }
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [titleStackView, expandableButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            expandableButton.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor, constant: -18),
            expandableButton.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 2),
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
