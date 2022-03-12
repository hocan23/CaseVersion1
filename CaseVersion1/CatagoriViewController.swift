//
//  CatagoriViewController.swift
//  CaseVersion1
//
//  Created by Hasan onur Can on 10.03.2022.
//

import UIKit

class CatagoriViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var selectedIndexPaths = Set<IndexPath>()
    let controller = ProductViewController()
    var filtCat = [String]()
    var data : [String: String] = [:]
    var categori = ["ELEKTRONİK","TAKI","ERKEK GİYİM","KADIN GİYİM"]
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        return table
    }()
    let btnFilter : UIButton = {
        let btn = UIButton()
        btn.setTitle("FİLİTRELE", for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(red: 240/255, green: 165/255, blue: 0/255, alpha: 1)
        btn.addTarget(self, action: #selector(btnLoginPressed), for: .touchUpInside)
        btn.isEnabled = true
        return btn
    }()
    
    @objc fileprivate func btnLoginPressed(){
                
        NotificationCenter.default.post(name: Notification.Name("categoriChanged"), object: nil, userInfo: data)
        dismiss(animated: true, completion: nil)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(btnFilter)
        butonlariEkle()
        
    }
    
    fileprivate func butonlariEkle() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "KATEGORİLER"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "İptal Et", style: .plain, target: self, action: #selector(btnCancelPressed))
        
    }
    @objc func btnCancelPressed() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.65)
        
        btnFilter.anchor(top: tableView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 60, paddingBottom: 0, paddingLeft: 70, paddingRight: -70, width: 0, height: 70)
        
    }
}

extension CatagoriViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categori.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categori[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndexPaths.contains(indexPath) { //deselect
            selectedIndexPaths.remove(indexPath)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            data[String(indexPath.row)] = nil
            
        }
        else{
            selectedIndexPaths.insert(indexPath) //select
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            data[String(indexPath.row)] = categori[indexPath.row]
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}






