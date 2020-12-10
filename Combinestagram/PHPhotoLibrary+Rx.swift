//
//  PHPhotoLibrary+Rx.swift
//  Combinestagram
//
//  Created by SungHo Han on 2020/12/09.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
  static var authorized: Observable<Bool> {
    return Observable.create { (observer) -> Disposable in
      
      DispatchQueue.main.async {
        if authorizationStatus() == .authorized {
          observer.onNext(true)
          observer.onCompleted()
        } else {
          observer.onNext(false)
          requestAuthorization { (newStatus) in
            observer.onNext(newStatus == .authorized)
            observer.onCompleted()
          }
        }
      }
      
      return Disposables.create()
    }
  }
}
