//
//  EmptyArticlesCell.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

import UIKit

class EmptyArticlesCell: UICollectionViewCell {
    static let identifier = "EmptyArticlesCell"
    
    private let emptyIcon: UILabel = {
        let label = UILabel()
        label.text = "😔"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Nenhum artigo foi encontrado"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(emptyIcon)
        contentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            emptyIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            
            messageLabel.topAnchor.constraint(equalTo: emptyIcon.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ])
    }
    
    func configureEmptyView() {
        // This function is intentionally left empty as we've already set up the static content
        // You can add any dynamic configuration here if needed in the future
    }
}
