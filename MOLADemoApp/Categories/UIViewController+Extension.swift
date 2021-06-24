//
//  UIViewController+Extension.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/23.
//

import Foundation
import UIKit

protocol LoadingViewProtocol {
    func getLoadingView() -> LoadingView
    func getErrorView() -> UIView
}

extension UIViewController{
    func loadingShow(vc: LoadingViewProtocol) {
        let loading = vc.getLoadingView()
        loading.frame = view.bounds
        view.addSubview(loading)
        loading.loadingViewShow()
    }
    
    func loadingDismiss(vc: LoadingViewProtocol) {
        let loading = vc.getLoadingView()
        loading.loadingViewdismiss()
    }
    
    func loadingError(vc: LoadingViewProtocol) {
        let errorView = vc.getErrorView()
        view.addSubview(errorView)
    }
    

}
