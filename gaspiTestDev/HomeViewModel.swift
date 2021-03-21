//
//  HomeViewModel.swift
//  gaspiTestDev
//
//  Created by Brian Baragar on 20/03/21.
//

import Foundation
import RxSwift
class HomeViewModel {
    private weak var view: HomeViewController?
    private var router: HomeRouter?
    private var managerConection = ManagerConection()
    
    func bind(view: HomeViewController, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func searchProduct(product: String) -> Observable<[Product]>{
        return managerConection.searchProduct(product: product)
    }
}
