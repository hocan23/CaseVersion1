//
//  LoginViewController.swift
//  CaseVersion1
//
//  Created by Hasan onur Can on 8.03.2022.
//

import UIKit

class LoginViewController: UIViewController {
        
    let logoView : UIImageView = {
        let logoView = UIImageView(image: #imageLiteral(resourceName: "tren"))
        logoView.contentMode = .scaleAspectFill
        return logoView
    }()
    
    let txtEmail :UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email adresinizi giriniz..."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.layer.cornerRadius = 20
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(changInfo), for: .editingChanged)
        return txt
    }()
    
    let txtPassword :UITextField = {
        let txt = UITextField()
        txt.placeholder = "Parolanızı giriniz..."
        txt.isSecureTextEntry = true
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.layer.cornerRadius = 20
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(changInfo), for: .editingChanged)
        return txt
    }()
    
    @objc fileprivate func changInfo() {
        
        let isValid = (txtEmail.text?.count ?? 0) > 0 &&
        (txtPassword.text?.count ?? 0) > 0
        if isValid {
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = UIColor(red: 20/255, green: 155/255, blue: 235/255, alpha: 1)
        } else {
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        }
    }
    
    let lblText : UILabel = {
        let lbl = UILabel()
        lbl.text = "HESABINA GİRİŞ YAP"
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 20
        lbl.isUserInteractionEnabled = false
        lbl.backgroundColor = .white
        return lbl
    }()
    let lblForgetPassword : UILabel = {
        let lbl = UILabel()
        lbl.text = "Şifremi unuttum."
        lbl.textAlignment = .right
        
        lbl.layer.cornerRadius = 20
        lbl.isUserInteractionEnabled=false
        lbl.backgroundColor = .white
        return lbl
    }()
    
    let btnRegister : UIButton = {
        let btn = UIButton()
        let attrBaslik = NSMutableAttributedString(string: "Henüz bir hesabınız yok mu?", attributes: [
            .font : UIFont.systemFont(ofSize: 16),
            .foregroundColor : UIColor.lightGray])
        attrBaslik.append(NSAttributedString(string: " Kayıt Ol.", attributes: [
            .font : UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor : UIColor.black
        ]))
        btn.setAttributedTitle(attrBaslik, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(btnRegisterPressed), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func btnRegisterPressed(){
        
    }
    
    let btnLogin : UIButton = {
        let btn = UIButton()
        btn.setTitle("GİRİŞ YAP", for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        btn.addTarget(self, action: #selector(btnLoginPressed), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    @objc fileprivate func btnLoginPressed(){
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let mainTabBarController = keyWindow?.rootViewController as? MainUITaViewController else { return }
        mainTabBarController.designPage()
        self.dismiss(animated: true, completion: nil)
   
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoView)
       
        designLogin()
   
    }
    fileprivate func designLogin() {
        let stackView = UIStackView(arrangedSubviews: [lblText,txtEmail,txtPassword,lblForgetPassword,btnLogin,btnRegister])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        logoView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 80, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.5, height: 150)
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.anchor(top: logoView.bottomAnchor, bottom: view.bottomAnchor , leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 50, paddingBottom: -200, paddingLeft: 40, paddingRight: -40, width: 0, height: 0)
    }
}


