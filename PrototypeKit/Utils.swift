//
//  Utils.swift
//  PrototypeKit
//
//  Created by Nicholas Tian on 13/2/18.
//  Copyright © 2018 nickTD. All rights reserved.
//

import Foundation

/// Taken from [Argo - JSONFileReader](https://github.com/thoughtbot/Argo/blob/master/Tests/ArgoTests/JSON/JSONFileReader.swift)
func json(fromFile file: String) -> Any? {
    return Bundle(for: JSONFileReader.self).path(forResource: file, ofType: "json")
        .flatMap { URL(fileURLWithPath: $0) }
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap(JSONObjectWithData)
}

private func JSONObjectWithData(fromData data: Data) -> Any? {
    return try? JSONSerialization.jsonObject(with: data, options: [])
}

private class JSONFileReader { }
