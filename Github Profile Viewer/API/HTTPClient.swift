//
//  HTTPClient.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/9/22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
