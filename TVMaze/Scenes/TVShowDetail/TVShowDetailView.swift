//
//  TVShowDetailView.swift
//  TVMaze
//
//  Created by Râmede on 29/04/22.
//

import UIKit

final class TVShowDetailView: UIView {
    
    // MARK: - Private Properties
    private var nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Private Implemantation
private extension TVShowDetailView {
    
    func setup() {
        setupNameLabel()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "TVShowDetailView"
    }
    
    func setupHierarchy() {
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}
