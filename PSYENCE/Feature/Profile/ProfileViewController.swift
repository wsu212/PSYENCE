//
//  ProfileViewController.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

final class ProfileViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(appearance: appearance.titleAppearance)
        label.text = profile.name
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(appearance: appearance.subtitleAppearance)
        label.text = profile.bio
        return label
    }()
    
    private let profileImageView: UIImageView = {
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
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let profile: Profile
    let appearance: ViewPresentable
    
    // MARK: - Initializer
    
    init(profile: Profile, appearance: ViewPresentable) {
        self.profile = profile
        self.appearance = appearance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        [profileImageView,
         titleLabel,
         subtitleLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        view.addSubview(verticalStackView)
        
        if let url = profile.imageURL {
            profileImageView.load(url: url, completion: nil)
        }
    }
    
    private func configureConstraints() {
        verticalStackView.pin(to: view, inset: 44.0)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 144.0),
            profileImageView.heightAnchor.constraint(equalToConstant: 144.0)
        ])
    }
}
