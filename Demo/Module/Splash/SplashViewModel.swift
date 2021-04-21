//
//  SplashViewModel.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import RxSwift
import RxCocoa

// MARK: - ViewModel protocols to communicate viewmodel to view controller
protocol SplashViewModelDelegate: class {
}

class SplashViewModel {
    let redirectToHome = PublishSubject<Void>()

}
