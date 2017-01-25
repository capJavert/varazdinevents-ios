//
//  LoginController.swift
//  VzLife
//
//  Created by FOI on 29/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let loginCellId = "loginCellId"
    var user = User()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var loginCell: LoginCell?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nazad", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(cancleIt), for: .allTouchEvents)

        return button
    }()
    
    var backButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        view.addSubview(collectionView)
        view.addSubview(backButton)
     //   view.backgroundColor = .orange
        backButtonTopAnchor = backButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        collectionView.backgroundColor = UIColor(netHex:0xFFBB46)
        //self.tabBarController?.tabBar.isHidden = true
       // self.tabBarController?.tabBar.layer.isHidden = true
        

        registerCells()
    }
 /*   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    
    }*/
    
 
    func finishLogin(username: String, password: String) {
       // print("Ovo je user", (loginCell?.emailTextField.text!)!)
        if(NetworkConnection.Connection.isConnectedToNetwork()){
            webServiceDataLoader.onUserLoggedDelegate = self
            webServiceDataLoader.LoadUser(username: username, password: password)
        }else{
            dbDataLoader.onUserLoggedDelegate = self
            dbDataLoader.LoadData()
        }

            }
    
    public func cancleIt(){
        
        let eventsView = self.storyboard?.instantiateViewController(withIdentifier: "eventsView") as! EventController
        self.navigationController?.pushViewController(eventsView, animated: true)
        
       
    }
    
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
    //For showing keyboard when textfield is touched and the View will go little bit up because of keyboard
    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    //made for scrolling left/right, think we don't need it but justin case
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    fileprivate func registerCells() {
        //...
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
        loginCell.loginController = self
        return loginCell
        
    }
    
    
    /*@IBAction func loginAction(sender: AnyObject){
        
        if emailTextField.text?.characters.count == nil {
        
            let alert = UIAlertView(title: "Greška", message: "Email mora biti upisan",delegate: self, cancelButtonTitle: "U redu")
            alert.show()
            
        }else if passwordField.text?.characters.count == nil {
        
            let alert = UIAlertView(title: "Greška", message: "Lozinka mora biti upisana",delegate: self, cancelButtonTitle: "U redu")
            alert.show()
        
        }else{
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
            spinner.startAnimating()
        }*/
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

}

extension LoginController: OnUserLoggedDelegate {
    public func onUserLogged(user: User) {
         self.user=user
        
        let eventsView = self.storyboard?.instantiateViewController(withIdentifier: "eventsView") as! EventController
        eventsView.user = user
        let rootView = self.navigationController?.popToRootViewController(animated: false)
        self.navigationController?.pushViewController((rootView?[0])!, animated: false)

        collectionView.reloadData()
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

