//
//  ServerRepository.swift
//  CryptoNiteIO
//
//  Created by LogicAppSourceIO on 30/05/2017.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import Foundation
import Alamofire

class ServerRepository {
    
    let baseURL_Currency = URL(string: "https://www.cryptocompare.com/api/data/coinlist/")!
    
    let manager: SessionManager
    
    init() {
        let sessionConfiguration = SessionManager.default.session.configuration
        sessionConfiguration.timeoutIntervalForRequest = 20.0
        self.manager = SessionManager(configuration: sessionConfiguration)
    }
    

    
}



extension ServerRepository: CurrencyRepository {
    func listAllCryptoCurrencies(completion: @escaping (DataResponse<[CryptoCurrencies]>) -> Void) {
        manager
            .request(baseURL_Currency).responseSerializable(completion, unwrapper: {dictionary, _ in
                    return dictionary["results"]
            })
    }

    
    
    
    
    
    
    

    
}
