//
//  RequestCacher.swift
//  Platform
//
//  Created by Mạnh Lương on 19/06/2023.
//

import Foundation
import Alamofire
import RxSwift
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import CryptoKit
import RXNetworking

class RequestDataCacher {
    static var dataFolder: URL {
        let url = BaseFileManager.rootFolder.appendingPathComponent("RequestDataCacher")
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }
    
    static func identifier(for request: URLRequest) -> String {
        let key = request.url?.absoluteString ?? ""
        return key.MD5String
    }
    
    static func saveResponseData(_ data: Data, for request: URLRequest) {
        let fileName = identifier(for: request)
        saveResponseData(data, for: fileName)
    }
    
    static func saveResponseData(_ data: Data, for identifier: String) {
        debugPrint("\(#function) \(identifier)")
        let fileName = identifier
        let file = dataFolder.appendingPathComponent(fileName)
        
        do {
            try data.write(to: file, options: .atomic)
        } catch {
            print("error saving cache file with error", error.localizedDescription)
        }
    }
    
    static func responseData(for request: URLRequest) -> Observable<Data?> {
        let fileName = identifier(for: request)
        return responseData(for: fileName)
    }
    
    static func responseData(for identifier: String) -> Observable<Data?> {
        debugPrint("\(#function) \(identifier)")
        let fileName = identifier
        let file = dataFolder.appendingPathComponent(fileName)
        
        let request = URLRequest(url: file)
        return NetworkingManager.request(request)
            .asObservable()
    }
    
    static func handleDataResponse(_ data: Observable<Data?>, cacheKey: String) -> Observable<Data?> {
        var cachedData = responseData(for: cacheKey)
        
        return data
            .flatMap { data -> Observable<Data?> in
                if let data = data {
                    RequestDataCacher.saveResponseData(data, for: cacheKey)
                    return .just(data)
                } else {
                    return cachedData
                }
            }
            .catch { error in
                return cachedData
                    .flatMap { data -> Observable<Data?> in
                        if let data = data {
                            return .just(data)
                        } else {
                            return .error(error)
                        }
                    }
            }
            .observe(on: MainScheduler.asyncInstance)
    }
}

extension APIClient {
    func cachedRequest<T: Decodable>(type: T.Type, endpoint: EndPoint) -> Observable<APIResponse<T>> {
        let cacheKey = endpoint.cacheKey
        
        let data = APIClient(bundle: .unknow).requestData(endpoint: endpoint)
            .asObservable()
        
        return RequestDataCacher.handleDataResponse(data, cacheKey: cacheKey)
            .flatMap {
                APIClient.convertDataResponse(data: $0, to: T.self)
            }
    }
}

extension EndPoint {
    var cacheKey: String {
        return "\(self)".MD5String
    }
}

extension String {
    var MD5: Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using: .utf8)!
        var digestData = Data(count: length)
        
        _ = digestData
            .withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData
                    .withUnsafeBytes { messageBytes -> UInt8 in
                        let baseAddress = messageBytes.baseAddress
                        let bytes = digestBytes.bindMemory(to: UInt8.self)
                        guard let messageBytesBaseAddress = baseAddress,
                              let digestBytesBlindMemory = bytes.baseAddress
                        else { return 0 }
                        
                        let messageLength = CC_LONG(messageData.count)
                        
                        return CC_MD5(
                            messageBytesBaseAddress,
                            messageLength,
                            digestBytesBlindMemory)
                        .pointee
                    }
            }
        return digestData
    }
    
    var MD5String: String {
        return MD5.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

