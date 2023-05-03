//
//  ServiceProvider.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/27.
//

import Foundation
import UIKit

protocol ServiceProviderType {
    func alertService(_ context:UIViewController)->AlertServiceType
    func animator(_ context:UIViewController)-> AnimatorType
    func datePicker(_ context:UIViewController)-> DatePickerServiceType
    func routingService(_ context:UIViewController)
    var apiService: ApiServiceType { get }
}

class ServiceProvider: ServiceProviderType{
   
    var apiService: ApiServiceType
    static let shaerd = ServiceProvider()
    init() {
        self.apiService = ApiService()
    }
    func alertService(_ context: UIViewController) -> AlertServiceType {
        return AlertService(context)
    }
    func animator(_ context: UIViewController) -> AnimatorType {
        return Animator(context)
    }
    func datePicker(_ context: UIViewController) -> DatePickerServiceType {
        return DatePickerService(context)
    }
    func routingService(_ context:UIViewController){
        
    }
}
