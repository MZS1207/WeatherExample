//
//  RestClient.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/26/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Alamofire

struct RestClient {
    
    typealias SuccessCompletion<Data> = ((Data) -> Void)?
    typealias FailureCompletion = ((RemoteResourceError) -> Void)?
    
    static let shared = RestClient()
    
    func request(_ request: Request , success: SuccessCompletion<Data>, failure: FailureCompletion) {
        let request = prepareRequest(request)
        request.validate().response { (response) in
            do {
                try self.validateResponse(response)
                var data = Data()
                if let _data = response.data {
                    data = _data
                }
                success?(data)
            }catch {
                let responseError = error as? RemoteResourceError ?? RemoteResourceError.generic
                failure?(responseError)
            }
        }
    }
}
private extension RestClient {
    func prepareRequest(_ request: Request) -> DataRequest {
        let endpointUrl = "\(request.path)"
        return Alamofire.request(endpointUrl, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers)
    }
    
    func validateResponse(_ response: DefaultDataResponse) throws {
        let statusCode = response.response?.statusCode ?? 0
        
        switch statusCode {
        case 401:
            throw RemoteResourceError.invalidCredentials
        case 500..<Int.max:
            throw RemoteResourceError.server(statusCode: statusCode)
        case 400..<500:
            throw RemoteResourceError.request(statusCode: statusCode)
        case 0:
            if let urlError = response.error as? URLError {
                switch urlError.code {
                case URLError.timedOut:
                    throw RemoteResourceError.timeout
                case URLError.notConnectedToInternet, URLError.networkConnectionLost:
                    throw RemoteResourceError.noInternetConnection
                default:
                    throw RemoteResourceError.generic
                }
            }else {
                throw RemoteResourceError.notValidUrl
            }
        default:
            break
        }
    }
}
