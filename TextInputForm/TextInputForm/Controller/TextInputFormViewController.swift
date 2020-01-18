//
//  TextInputFormViewController.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class TextInputFormViewController: UIViewController {
  
  private struct Padding {
    static let xPadding: CGFloat = 32
    static let yPadding: CGFloat = 8
  }
  
  private var visibleIndex = 0
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
    navigationItem.title = "Sign Up"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func formUpdateAnimate() {
    visibleIndex += 1
    
    guard forms.count > visibleIndex else { return }
    
    UIView.animate(withDuration: 0.2) { [weak self] in
      guard let `self` = self else { return }
      for i in 0...(self.visibleIndex - 1) {
        self.topConstraints[i].constant += Padding.yPadding + self.forms[self.visibleIndex].frame.height
      }
      self.view.layoutIfNeeded()
    }
    
    UIView.animate(
      withDuration: 0.2,
      delay: 0.1,
      options: [],
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.forms[self.visibleIndex].alpha = 1
        self.view.layoutIfNeeded()
    })
    
    titleLabel.text = formData[visibleIndex].title
  }
  
  private func baseUI() {
    titleLabel.backgroundColor = .white
    titleLabel.text = formData[visibleIndex].title
    titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    
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
      mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ])
  }
  
  private func createForm() {
    formData.enumerated().forEach {
      switch $1.type {
      case .text(let sub, let type):
        let tempForm = TextForm(sub: sub, keyBoardType: type)
        tempForm.tag = $0
        tempForm.delegate = self
        forms.append(tempForm)
        mainScrollView.addSubview(tempForm)
        
      case .birth(let year, let month, let day):
        let tempForm = BirthForm(year: year, month: month, day: day)
        tempForm.tag = $0
        tempForm.delegate = self
        forms.append(tempForm)
        mainScrollView.addSubview(tempForm)
      }
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
        forms[$0].targetTextField?.becomeFirstResponder()
        $1.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Padding.yPadding).isActive = true
      } else {
        $1.alpha = 0
      }
    }
  }
}

extension TextInputFormViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension TextInputFormViewController: FormDelegate {
  func nextFocus(tag: Int) {
    formUpdateAnimate()
    forms[tag + 1].targetTextField?.becomeFirstResponder()
  }
}
