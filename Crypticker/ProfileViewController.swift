//
//  ProfileViewController.swift
//  CryptoNiteIO
//
//  Created by LogicAppSourceIO on 21/06/2017.
//  Copyright (c) 2017 LogicAppSourceIO. All rights reserved.
//    //presenter communicater kun fra viewvVC
import UIKit

class ProfileViewController: UIViewController {
    //1. JSON API Key
    //2. Return - Coins Name, Ammount
    //3. MAke serpent request -> save under that specific user
    //4. Display i Appen.
    
    
    //Do i need a token/id for specific user ?
    // Javascript ?
    // Save in model ?
    // Caching -> comparing
    // Background Fetch/Task
    //sLink Global ?
    // nested Entry []
    
    
    var sKey = ""
    
    @IBOutlet weak var JSONApiTxtField: UITextField!
    
    @IBAction func btnApi(_ sender: Any) {
        presenter.getData()
//        JSONApiTxtField.text? = sKey
//        concatApiKeyFromUser(sKey: sKey)
//        print(sKey)
    }
    
    
    func concatApiKeyFromUser(sKey: String) -> String {
        var sLink = "https://spreadsheets.google.com/feeds/list/ \(sKey) /1/public/full?alt=json";
        print(sLink)
        return sLink
    }
    
    
    let presenter: ProfilePresenterInput

    convenience init(presenter: ProfilePresenterInput) {
        self.init(presenter: presenter, nibName: nil, bundle: nil)
    }

    init(presenter: ProfilePresenterInput, nibName: String?, bundle: Bundle?) {
        self.presenter = presenter
        super.init(nibName: nibName, bundle: bundle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -

}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ProfileViewController: ProfilePresenterOutput {
    func display(_ displayModel: Profile.DisplayData.Currency) {
        JSONApiTxtField.text = "\(displayModel.btc) og \(displayModel.btcValue)"
        
        print ("\(displayModel.btc) og \(displayModel.btcValue)") // displayModel.btc = BTC
        //print("\(displayModel.btc) \n \(displayModel.eth) \n \(displayModel.tsst) \n \(displayModel.xrp) ")
    }
    
    func display(_ error: Profile.DisplayData.Error) {
        
        let alert = UIAlertController(title: "Fejl!", message: error.message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }

}




