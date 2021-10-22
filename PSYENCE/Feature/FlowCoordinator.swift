//
//  FlowCoordinator.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

final class FlowCoordinator {
    private var rootViewController: UIViewController?
    
    lazy var navigationController: UINavigationController? = {
        guard let rootViewController = rootViewController else { return nil }
        return .init(rootViewController: rootViewController)
    }()
    
    func start() {
        rootViewController = makeListViewController()
    }
    
    private func makeListViewController() -> ListViewController {
        let service = ListService<StaffPicks>(endpoint: .staffpicks)
        let viewModel = ListViewModel(title: "Photos Feed", service: service)
        let viewController = ListViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    private func makeLocationViewController(author: Author) -> LocationViewController {
        let viewModel = LocationViewModel(author: author)
        let viewController = LocationViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    private func makeProfileViewController(author: Author) -> ProfileViewController {
        let appearance = ProfileViewAppearance(titleAppearance: .profileTitle, subtitleAppearance: .profileSubtitle)
        let viewController = ProfileViewController(author: author, appearance: appearance)
        return viewController
    }
}

extension FlowCoordinator: ListViewControllerDelegate {
    func userDidTapPhotoTaken(by author: Author) {
        let vc = makeLocationViewController(author: author)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FlowCoordinator: LocationViewControllerDelegate {
    func userDidTapAnnotation(author: Author) {
        let vc = makeProfileViewController(author: author)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
