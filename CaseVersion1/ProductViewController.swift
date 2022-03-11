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
        print("hjkhkj")
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
   
    var filterCatagory : [String]?
    var products = [Product]()
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        print(filterCatagory)

        super.viewDidLoad()
        view.backgroundColor = .white
        design()
        productService()
        
   
    }
    
    
    


        

        
        
    
    
    
//    func filter (){
//
//            for a in 0...products.count-1{
//                if products[a].category == "men's clothing" {
//                    filterProducts.append(products[a])
//
//        }
//
//        }
//    }
    
    
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

        collectionView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.8)
        btnFilter.anchor(top: view.topAnchor, bottom: collectionView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:70, paddingBottom: -70, paddingLeft: 200, paddingRight: -100, width: 0, height: 0)
        btnOrder.anchor(top: view.topAnchor, bottom: collectionView.topAnchor, leading: view.leadingAnchor, trailing: btnFilter.leadingAnchor, paddingTop:70, paddingBottom: -70, paddingLeft: 100, paddingRight: 20, width: 0, height: 0)
    }
    func productService(){
        let service = Service(urlString: "https://fakestoreapi.com/products")
        service.performRequest{(result: Result<[Product],ServiceError>) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async{
                    self.products=products

                    self.collectionView!.reloadData()

                }
            case .failure(let error):
                print(error)
            }
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as! ProductCollectionCell
 
            cell.myLabel.text = products[indexPath.row].title
            let url = URL(string: products[indexPath.row].image )
            cell.imageView.sd_setImage(with: url, completed: nil)
        

        
        
        return cell
    }
    
    
}





