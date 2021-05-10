//
//  LoadImageServiceProtocol.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import Foundation

protocol LoadServiceProtocol {
    func loadImage(by path: String, completion: @escaping (Data?) -> ())
}
