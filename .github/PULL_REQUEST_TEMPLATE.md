name: Pull Request Tamplate
about: PR 템플릿
title: "[Label] PR Title"

body:
  - type: textarea
    id: issue-number
    attributes:
      label: Issue Number
      description: 관련된 이슈 번호
      value: 🔒 Close #
    validations:
      required: false
  - type: textarea
    id: changed-files
    attributes:
      label: Changed Files
      description: 변경된 파일들
      placeholder: ex) Appname/Entity/Dictionary/Content/DictionaryContent.swift
    validations:
      required: true
  - type: textarea
    id: pull-request-content
    attributes:
      label: Pull Request 내용
      description: 변경 및 추가된 사항들
      placeholder: "닉네임 설정 시, 공백을 Submit하면 Alert 표시"
    validations:
      required: true

## 관련 사진 gif 및 (Optional)

## Checklist

- [] merge할 branch를 확인했나요?
- [] coding conventions을 지켰나요?
- [] 이 PR에 관계없는 변경사항들이 없나요?
- [] PR 날리는 코드를 self 리뷰 했나요?
