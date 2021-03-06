//
//  TodayEthViewController.swift
//  ETH Widget
//
//  Created by LogicAppSourceIO on 31/05/2017.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import NotificationCenter
import CryptoCurrencyKit
import Serpent
import Alamofire

//Epanding widget /more/less missing - Green + Red Color  + Graph implementation. 
//Notification for price change

class TodayEthViewController: CurrencyDataViewController, NCWidgetProviding {
    
    
let baseURL_Price = URL (string: "https://api.coinmarketcap.com/v1/ticker/?convert=EUR&limit=100")
    
    
    @IBOutlet weak var ethPriceLbl: UILabel!
    @IBOutlet weak var ethPriceChangeLbl: UILabel!
    var lineWidth: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        

        requestEthData{ (response) in
            switch response.result {
            case .success(let ethereumData):
                
                for currency in ethereumData {
                    
                    if(currency.name == "Ethereum") {
                        print(currency.price_usd)
                        print(currency.percent_change_1h)
                        
                        self.ethPriceLbl.text = "$ \(currency.price_usd)"
                        self.ethPriceChangeLbl.text = currency.percent_change_1h
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
        
    }
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
    
    
 
    //GET Ethereum Endpoint - API
    func requestEthData(completion: @escaping (DataResponse<[ExchangeRate]>) -> Void) {
        request(baseURL_Price!).responseSerializable(completion)
    }
    
        
    
    
    
}
