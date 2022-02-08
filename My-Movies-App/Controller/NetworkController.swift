//
//  NetworkController.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 12/1/2565 BE.
//

import Foundation
import Alamofire

protocol FetchHomePageDelegate {
    func didHomeDataLoaded(_ homeModel:DashboardModel)
    func didFailWithError(_ error:Error)
}

struct NetworkController {
    
    let prefixURL = "https://jsonkeeper.com/b/0GQ8"
    var delegate:FetchHomePageDelegate?
    
    func fetchData() {
        AF.request(prefixURL)
            .responseDecodable(of: DashboardModel.self) { (response) in
                //debugPrint(response)
                switch response.result {
                case .success:
                    if let homeData = response.value {
                        self.delegate?.didHomeDataLoaded(homeData)
                    }
                case let .failure(error):
                    self.delegate?.didFailWithError(error)
                }
                
            }
    }
}
