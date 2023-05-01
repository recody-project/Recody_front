//
//  ApiService.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/27.
//

import Foundation
protocol ApiServiceType {
    func send(_ command: ApiCommand ) 
}
class ApiService: ApiServiceType {
    func send(_ command: ApiCommand ) {
         ApiClient.request(command: command, { result in
//             self.delegate?.complete(orderNumber: self.order, result: result)
         }, { msg in
//             self.delegate?.failed(orderNumber: self.order, msg: msg)
         })
     }
}
