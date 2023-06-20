//
//  ViewController.swift
//  GitApp

import UIKit

protocol MainDelegate where Self: AnyObject {
    func presentData(login: String, description: String)
    func presentError(message: String)
}

protocol MainViewModable {
    var mainDelegate: MainDelegate? { get }
    func fetchData()
}

final class MainViewModel: MainViewModable {
    
    private(set) weak var mainDelegate: MainDelegate?
    private let api: APIProtocol
    
    init(api: APIProtocol = API(), delegate: MainDelegate?) {
        self.api = api
        self.mainDelegate = delegate
    }
    
    func fetchData() {
        api.getGists(session: URLSession.shared, endpoint: .getGists(id: "a88b2a942084c0e66b34d0db5f7cf2e5")) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.mainDelegate?.presentData(login: response.owner?.login ?? "", description: response.description ?? "")
                case let .failure(error):
                    self?.handlerError(error: error)
                }
            }
        }
    }
    
    func handlerError(error: GitAppError) {
        switch error {
        case .urlError:
            self.mainDelegate?.presentError(message: "URL error")
        case .parseError:
            self.mainDelegate?.presentError(message: "ParseError")
        case .requestError:
            self.mainDelegate?.presentError(message: "RequestError")
        }
    }
}

final class ViewController: UIViewController {
    
    var viewModel: MainViewModable?
    
    // MARK: - Outlets
    @IBOutlet private weak var textViewGists: UITextView!
    
    override func loadView() {
        super.loadView()
        viewModel = MainViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Dummy", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: Actions
    @IBAction private func actionFetch(_ sender: Any) {
        viewModel?.fetchData()
    }
}

extension ViewController: MainDelegate {
    
    func presentData(login: String, description: String) {
        self.textViewGists.text = "Owner: \(login)\nDescription: \(description)"
    }
    
    func presentError(message: String) {
        showErrorAlert(message: message)
    }
}
