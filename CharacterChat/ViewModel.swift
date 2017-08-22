//
//  ViewModel.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//
import UIKit

protocol ViewModelConfigurable: class {
    associatedtype ViewModelType
    
    init(viewModel: ViewModelType)
    func configure(with viewModel: ViewModelType)
}

func viewForViewModel<V: ViewModelConfigurable>(_ viewModel: V.ViewModelType) -> V {
    return V(viewModel: viewModel)
}

protocol ViewModel {
    associatedtype ViewType: UIView, ViewModelConfigurable
    
    func makeView() -> ViewType
}


extension ViewModel where ViewType.ViewModelType == Self {
    func makeView() -> ViewType {
        return viewForViewModel(self)
    }
}
