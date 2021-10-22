//
//  ListViewController.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/19.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func userDidTapPhotoTaken(by author: Author)
}

class ListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        return tableView
    }()
    
    private var viewModel: ListViewModelType
    
    weak var delegate: ListViewControllerDelegate?
    
    // MARK: - Initializer
    
    init(viewModel: ListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        configureSubviews()
        configureBindings()
        
        viewModel.getList()
    }
    
    // MARK: - Private Helper Methods
    
    private func configureSubviews() {
        view.addSubview(tableView)

        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 44.0)
        tableView.tableFooterView = spinner
        
        tableView.pin(to: view)
    }
    
    private func configureBindings() {
        viewModel.didRetrieveItems = { [weak self] in
            self?.reloadTableView()
        }
        viewModel.didFailRetrieveItems = { [weak self] in
            self?.presentAlertController()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func presentAlertController() {
        let alertController = UIAlertController(title: "Whoops, looks like we hit a network issue.",
                                                message: nil,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in self?.viewModel.getList() }
        
        [defaultAction, retryAction].forEach { alertController.addAction($0) }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell
        let item = viewModel.item(at: indexPath.row)
        let appearance = CellAppearance(titleAppearance: .title, subtitleAppearance: .subtitle)
        cell?.configure(with: item, appearance: appearance)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isLastItemReached(at: indexPath) {
            viewModel.getList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let author = viewModel.item(at: indexPath.row)?.author {
            self.delegate?.userDidTapPhotoTaken(by: author)
        }
    }
}


