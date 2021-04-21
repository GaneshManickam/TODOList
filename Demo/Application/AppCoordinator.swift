//
//  AppCoordinator.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//

import Foundation
import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let splash = SplashCoordinator(window: window)
        return coordinate(to: splash)
    }
}
