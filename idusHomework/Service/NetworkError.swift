//
//  NetworkError.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/12.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case responseError(statusCode: Int)
}
