//
//  Codable+Ext.swift
//  Alamofire
//
//  Created by Mạnh Lương on 22/06/2023.
//

import Foundation

extension Decodable {
    static func fromJSON(_ json: Any) throws -> Self {
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        return try fromData(jsonData)
    }
    
    static func fromData(_ data: Data) throws -> Self {
        let object = try JSONDecoder().decode(Self.self, from: data)
        
        return object
    }
}

extension Encodable {
    func toJSON() throws -> Any {
        let jsonData = try toData()
        
        let json = try JSONSerialization.jsonObject(with: jsonData)
        
        return json
    }
    
    func toData() throws -> Data {
        let jsonData = try JSONEncoder().encode(self)
        
        return jsonData
    }
}
