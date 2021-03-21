//
//  HomeViewController.swift
//  gaspiTestDev
//
//  Created by Brian Baragar on 20/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var products = [Product]()
    private var productToFind = ""
    
    lazy var seachController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.barStyle = .default
        controller.searchBar.placeholder = "Buscar Producto"
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manageSeachBarController()
    }
    
    private func manageSeachBarController(){
        let searchBar = seachController.searchBar
        seachController.delegate = self
        tableView.tableHeaderView = searchBar
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [self] (result) in
                if result.isEmpty{
                    print("vacio")
                }else{
                    productToFind = result
                }
            }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive (onNext: { [searchBar] in
                self.clickOnFindProduct()
                searchBar.searchTextField.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    private func clickOnFindProduct(){
        searchProduct(producto: productToFind)
    }
    
    private func searchProduct(producto: String){
        return viewModel.searchProduct(product: producto)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { products in
                self.products = products
                self.reloadTableView()
            }, onError: { error in
                print(error)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func configureTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "ProductViewCell")
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell") as! ProductViewCell
        cell.nameProduct.text = self.products[indexPath.row].title
        cell.priceProduct.text = self.products[indexPath.row].price.redondear()
        cell.imageProduct.imageFromServerURL(urlString: self.products[indexPath.row].getURLStringImage(), placeHolderImage: UIImage(named: "new-product")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        seachController.isActive = false
        reloadTableView()
    }
}
