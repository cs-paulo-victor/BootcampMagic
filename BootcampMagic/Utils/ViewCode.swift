//
//  File.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 18/03/21.
//

import Foundation

protocol ViewCode: class {
    func setupViews()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCode {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
    
    func setupAditionalConfiguration() { }
}
