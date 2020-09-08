//
//  AutorizationViewModel.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import RxSwift

struct AutorizationViewModel {
    
    let disposeBag = DisposeBag()
    let nameTextPublishSubject = PublishSubject<String>()
    let surnameTextPublishSubject = PublishSubject<String>()
    
    func observe() -> Observable<Bool> {
       return Observable.combineLatest(nameTextPublishSubject.asObservable(), surnameTextPublishSubject.asObservable()).map {$0 != "" && $1 != ""}
    }
    
    func observe(the textField: UITextField, completion: ( @escaping () -> Void) ) {
        textField.rx.controlEvent(.editingChanged)
        .asObservable()
            .subscribe(onNext: { completion() } )
            .disposed(by: disposeBag)
    }
}
