//
//  ItemCell.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit

class ItemCell: UITableViewCell {
        
    static let reuseIdentifier = String(describing: self)
    
    private let titleLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        itemImageView.image = nil
    }
    
    private func configureSubviews() {
        [itemImageView,
         titleLabel,
         subtitleLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(verticalStackView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 160.0),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
            ])
    }
    
    func configure<T: CellPresentable>(with item: Item?, appearance: T) {
        titleLabel.apply(appearance: appearance.titleAppearance)
        subtitleLabel.apply(appearance: appearance.subtitleAppearance)
        titleLabel.text = item?.name
        subtitleLabel.text = item?.description
        
        guard let url = item?.imageURL else { return }
        
        itemImageView.load(url: url) { _ in }
    }
}
