//
//  File.swift
//  CaseVersion1
//
//  Created by Hasan onur Can on 10.03.2022.
//

import Foundation
import UIKit
import SDWebImage

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    lazy var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Ürün adını giriniz..."
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return sb
    }()
    
    
    
    let btnFilter : UIButton = {
        let btn = UIButton()
        btn.setTitle("FİLTRELE", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        btn.addTarget(self, action: #selector(btnFilterPressed), for: .touchUpInside)
        btn.isEnabled = true
        return btn
    }()
    
    @objc fileprivate func btnFilterPressed(){
        
        
        present(CatagoriViewController(), animated: true, completion: nil)
    }
    
    let btnOrder : UIButton = {
        let btn = UIButton()
        btn.setTitle("SIRALA", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        btn.isEnabled = true
        btn.addTarget(self, action: #selector(btnOrderPressed), for: .touchUpInside)
        
        return btn
    }()
    @objc fileprivate func btnOrderPressed(){
        print("order")
    }
    
    var filterCatagory = [Product]()
    var products = [Product]()
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: Notification.Name("categoriChanged"), object: nil)
        
        design()
        productService()
        
        
    }
    
    // MARK: - NSNotification for Filtre

    
    @objc func notificationReceived(_ notification: NSNotification){
        filterCatagory.removeAll()
        if let info = notification.userInfo as? Dictionary<String,String> {
            
            // Check if value present before using it
            if info["0"] != nil {
                filter(cat: "electronics")
            }
            if info["1"] != nil {
                filter(cat: "jewelery")
            }
            
            if info["2"] != nil {
                filter(cat: "men\'s clothing")
            }
            if info["3"] != nil {
                filter(cat: "women\'s clothing")
            }
        }
       
        collectionView?.reloadData()
    }
  
    func filter (cat: String){
        for a in products{
            if a.category == cat {
                filterCatagory.append(a)
            }
        }
    }

    // MARK: - Design Screen

    func design(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (view.frame.size.width/2)-6, height: (view.frame.size.width/2)-6)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(btnFilter)
        view.addSubview(btnOrder)
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, bottom: navBar?.bottomAnchor, leading: navBar?.leadingAnchor, trailing: navBar?.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
        
        collectionView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.75)
        btnFilter.anchor(top: view.topAnchor, bottom: collectionView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:100, paddingBottom: -70, paddingLeft: 200, paddingRight: -100, width: 0, height: 0)
        btnOrder.anchor(top: view.topAnchor, bottom: collectionView.topAnchor, leading: view.leadingAnchor, trailing: btnFilter.leadingAnchor, paddingTop:100, paddingBottom: -70, paddingLeft: 100, paddingRight: 20, width: 0, height: 0)
    }
    
    // MARK: - WebService

    func productService(){
        let service = Service(urlString: "https://fakestoreapi.com/products")
        service.performRequest{(result: Result<[Product],ServiceError>) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async{
                    self.products=products
                    self.filterCatagory=products
                    
                    self.collectionView!.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - CollectionView Design

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filterCatagory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as! ProductCollectionCell
        
        cell.priceLbl.text = String (filterCatagory[indexPath.row].price)+"  TL"
        cell.myLabel.text = filterCatagory[indexPath.row].title
        let url = URL(string: filterCatagory[indexPath.row].image )
        cell.imageView.sd_setImage(with: url, completed: nil)
        return cell
    }
}


