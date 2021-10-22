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
    
    private func makeLocationViewController(item: Item) -> LocationViewController {
        let viewModel = LocationViewModel(item: item)
        let viewController = LocationViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    private func makeProfileViewController(profile: Profile) -> ProfileViewController {
        let appearance = ProfileViewAppearance(titleAppearance: .profileTitle, subtitleAppearance: .profileSubtitle)
        let viewController = ProfileViewController(profile: profile, appearance: appearance)
        return viewController
    }
}

extension FlowCoordinator: ListViewControllerDelegate {
    func userDidTapItem(_ item: Item) {
        let viewController = makeLocationViewController(item: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FlowCoordinator: LocationViewControllerDelegate {
    func userDidTapAnnotation(_ profile: Profile) {
        let vc = makeProfileViewController(profile: profile)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
