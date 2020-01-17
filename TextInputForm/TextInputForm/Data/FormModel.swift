//
//  FormModel.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/17.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

enum FormType {
  case base(BaseFormType)
  case number
}

enum BaseFormType {
  case nomarl
  case email
  case number
  case password
}

struct FormModel {
  let title: String
  let subTitle: String
  let type: FormType
}


var formData: [FormModel] = [
  FormModel(
    title: "이메일을 입력해주세요",
    subTitle: "이메일",
    type: FormType.base(BaseFormType.email)
  ),
  FormModel(
    title: "이름을 입력해주세요",
    subTitle: "이름",
    type: FormType.base(BaseFormType.nomarl)
  ),
  FormModel(
    title: "전화번호를 입력해주세요",
    subTitle: "전화번호",
    type: FormType.base(BaseFormType.number)
  ),
  FormModel(
    title: "닉네임을 입력해주세요",
    subTitle: "닉네임",
    type: FormType.base(BaseFormType.nomarl)
  ),
  FormModel(
    title: "취미를 적어주세요",
    subTitle: "취미",
    type: FormType.base(BaseFormType.nomarl)
  ),
  FormModel(
    title: "생년월일을 입력해주세요",
    subTitle: "생년월일",
    type: FormType.base(BaseFormType.number)
  ),
  FormModel(
    title: "성별을 입력해주세요",
    subTitle: "성별",
    type: FormType.base(BaseFormType.email)
  ),
  FormModel(
    title: "주소를 입력해주세요",
    subTitle: "주소",
    type: FormType.base(BaseFormType.nomarl)
  ),
  FormModel(
    title: "비밀번호를 입력해주세요",
    subTitle: "비밀번호",
    type: FormType.base(BaseFormType.password)
  ),
  FormModel(
    title: "비밀번호를 재입력해주세요",
    subTitle: "비밀번호",
    type: FormType.base(BaseFormType.password)
  )
]
