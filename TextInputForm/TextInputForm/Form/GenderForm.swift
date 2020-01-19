//
//  GenderForm.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/18.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class GenderForm: Form {
  
  private var subLabelCentYAnchor: NSLayoutConstraint?
  
  private let subLabel = UILabel()
  private let genderSegmentedControl = UISegmentedControl(items: ["남자", "여자"])
  
  init(sub: String?) {
    super.init(frame: .zero)
    
    subLabel.text = sub
    
    baseUI()
    constraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    subLabel.alpha = 0
    subLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
    self.addSubview(subLabel)
    
    genderSegmentedControl
      .setTitleTextAttributes([
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy)], for: .normal)
    self.segmentedControl = genderSegmentedControl
    genderSegmentedControl.addTarget(self, action: #selector(sengmentedControlValueChanged(_:)), for: .valueChanged)
    self.addSubview(genderSegmentedControl)
  }
  
  @objc
  private func sengmentedControlValueChanged(_ sender: UISegmentedControl) {
    delegate?.nextFocus(tag: self.tag)
    
    let moveDistance: CGFloat = 32
    UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: { [weak self] in
      self?.subLabelCentYAnchor?.constant = -moveDistance
      self?.subLabel.alpha = 1
      self?.layoutIfNeeded()
    })
  }
  
  private func constraint() {
    [subLabel, genderSegmentedControl].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
      $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Padding.inset).isActive = true
    }
    
    subLabelCentYAnchor = subLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    subLabelCentYAnchor?.isActive = true
    
    NSLayoutConstraint.activate([
      genderSegmentedControl.topAnchor.constraint(equalTo: self.topAnchor, constant: Padding.topSpace),
      genderSegmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Padding.bottomSpace),
      genderSegmentedControl.heightAnchor.constraint(equalToConstant: 48)
    ])
  }
}

