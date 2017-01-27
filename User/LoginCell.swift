//
//  LoginCell.swift
//  VzLife
//
//  Created by FOI on 30/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {

    let logoImageView: UIImageView = {
        let image = UIImage(named: "varazdinevents-logo-dark")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        //textField.placeholder = "Korisničko ime"
       // textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 2
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor( red: 255/255, green: 187/255, blue:70/255, alpha: 1.0 ).cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "Korisničko ime",
                                                             attributes: [NSForegroundColorAttributeName: UIColor( red: 255/255, green: 187/255, blue:70/255, alpha: 1.0 )])
        //textField.textAlignment = NSTextAlignment.center
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        //textField.placeholder = "Lozinka"
        textField.attributedPlaceholder = NSAttributedString(string: "Lozinka",
                                                            attributes: [NSForegroundColorAttributeName: UIColor( red: 255/255, green: 187/255, blue:70/255, alpha: 1.0 )])
        textField.layer.borderColor = UIColor( red: 255/255, green: 187/255, blue:70/255, alpha: 1.0 ).cgColor
        //textField.textAlignment = NSTextAlignment.center
        textField.layer.borderWidth = 2
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(netHex:0xFFBB46)
        button.setTitle("Prijava", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor( red: 255/255, green: 187/255, blue:70/255, alpha: 1.0 ).cgColor
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    
    // ? -> means optional, cuz' you want to initialize it as nil
    var loginController: LoginController?
    var eventController: EventController?
    
    func logIn(){
        
        loginController?.finishLogin(username: emailTextField.text!, password: passwordTextField.text!)
    }
    
   func cancle(){
        loginController?.cancleIt()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.contentView.frame.width-30)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 60, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 40)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    
}



