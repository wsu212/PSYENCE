//
//  FlowCoordinator.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import Foundation

final class FlowCoordinator {
    private var listViewController: ListViewController?
    private var locationViewController: LocationViewController?
    
    lazy var navigationController: UINavigationController? = {
        guard let listViewController = listViewController else { return nil }
        return .init(rootViewController: listViewController)
    }()
    
    func start() {
        listViewController = makeListViewController()
    }
    
    private func makeListViewController() -> ListViewController {
        let service = ListService<StaffPicks>(endpoint: .staffpicks)
        let viewModel = ListViewModel(title: "Images Feed", service: service)
        let viewController = ListViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    private func makeLocationViewController(user: Staff) -> LocationViewController {
        let viewModel = LocationViewModel(user: user)
        let viewController = LocationViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
}

extension FlowCoordinator: ListViewControllerDelegate {
    func userDidTapPhotoTaken(by user: Staff) {
        let vc = makeLocationViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FlowCoordinator: LocationViewControllerDelegate {
    func userDidTapAnnotation(user: Staff) {
        print("**** \(user)")
    }
}
