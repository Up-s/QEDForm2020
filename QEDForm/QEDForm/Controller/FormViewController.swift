//
//  FormViewController.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
  
  private struct Padding {
    static let xPadding: CGFloat = 24
    static let yPadding: CGFloat = 16
  }
  
  private var forms = [Form]()
  private var topConstraints = [NSLayoutConstraint]()
  
  private let titleLabel = UILabel()
  private let mainScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigation()
    baseUI()
    createForm()
    formsConstraint()
  }
  
  private func navigation() {
    navigationItem.title = "QED Form"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private var visibleFormTag = 0 {
    didSet {
      guard visibleFormTag == (forms.count - 1) else { return }
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(upload))
    }
  }
  
  @objc private func upload() {
    view.endEditing(true)
  }
  
  private func formUpdateAnimate(currentFormTag: Int) {
    // 마지막 입력을 알기위한 조건
    guard (forms.count - 1) > currentFormTag else { return }
    
    // 중간에 변경되었을때 애니매니션 및 텍스트필드 이동을 막기위해
    guard visibleFormTag == currentFormTag else { return }
    visibleFormTag += 1
    
    if let textField = forms[currentFormTag + 1].nextTarget as? UITextField {
      textField.becomeFirstResponder()
    } else {
      view.endEditing(true)
    }
    
    let duration = 0.5
    let delay = 0.2
    UIView.animate(withDuration: duration) { [weak self] in
      guard let `self` = self else { return }
      for i in 0...currentFormTag {
        self.topConstraints[i].constant += Padding.yPadding + self.forms[currentFormTag + 1].frame.height
      }
      self.view.layoutIfNeeded()
    }
    
    UIView.animate(
      withDuration: duration,
      delay: delay,
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.forms[currentFormTag + 1].alpha = 1
        self.view.layoutIfNeeded()
    })
    
    titleLabel.text = formData[currentFormTag].title
  }
  
  private func baseUI() {
    titleLabel.numberOfLines = 0
    titleLabel.backgroundColor = .white
    titleLabel.text = formData[0].title
    titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
    
    mainScrollView.alwaysBounceVertical = true
    mainScrollView.delegate = self
    mainScrollView.backgroundColor = .white
    
    let guide = view.safeAreaLayoutGuide
    
    [titleLabel, mainScrollView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Padding.yPadding),
      titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Padding.xPadding),
      titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Padding.xPadding),
      
      mainScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.yPadding),
      mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -Padding.yPadding)
    ])
  }
  
  private func createForm() {
    formData.enumerated().forEach {
      let tempForm: Form
      
      switch $1.type {
      case .text(let sub, let type):
        tempForm = TextForm(sub: sub, keyBoardType: type)
        
      case .birth(let year, let month, let day):
        tempForm = BirthForm(year: year, month: month, day: day)
        
      case .phone(let phone):
        tempForm = PhoneForm(first: phone)
        
      case .gender(let gender):
        tempForm = GenderForm(sub: gender)
        
      case .picker(let sub):
        tempForm = PickerForm(sub: sub)
      }
      
      tempForm.tag = $0
      tempForm.delegate = self
      forms.append(tempForm)
      mainScrollView.addSubview(tempForm)
    }
  }
  
  private func formsConstraint() {
    forms.enumerated().forEach {
      $1.translatesAutoresizingMaskIntoConstraints = false
      $1.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
      let tempTopConstraint = $1.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Padding.yPadding)
      tempTopConstraint.isActive = true
      topConstraints.append(tempTopConstraint)
      $1.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Padding.xPadding).isActive = true
      $1.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Padding.xPadding).isActive = true
      
      if $0 == 0 {
        forms[$0].nextTarget?.becomeFirstResponder()
        $1.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Padding.yPadding).isActive = true
      } else {
        $1.alpha = 0
      }
    }
  }
}

extension FormViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension FormViewController: FormDelegate {
  func nextFocus(tag: Int) {
    formUpdateAnimate(currentFormTag: tag)
  }
}
