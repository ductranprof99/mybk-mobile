//
//  UITableView.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

extension NSObject {
  public var identifier: String {
    String(describing: type(of: self))
  }

  public static var identifier: String {
    String(describing: self)
  }
}


// https://gist.github.com/thejohnlima/ebca08a6009bcf3ad160970dfaefc709
extension UITableView {
    
    /// Register nib cell
    /// - Parameter cell: nib cell to register
    func register<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellReuseIdentifier: name)
        } else {
            register(aClass, forCellReuseIdentifier: name)
        }
    }

    /// Register nib cell for header or footer
    /// - Parameter reusableView: reusable view to register
    public func registerHeaderFooter(_ reusableView: UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: reusableView.identifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: reusableView.identifier)
    }
    
    /// Register nib cell for header or footer
    /// - Parameters:
    ///   - nibName: nib name of the cell
    ///   - identifier: nib identifier
    public func registerHeaderFooter(nibName: String, identifier: String? = nil) {
        let nib = UINib(nibName: nibName, bundle: nil)
        if let identifier = identifier {
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(nib, forHeaderFooterViewReuseIdentifier: nibName)
        }
    }
    
    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    /// - Parameters:
    ///   - class: object type
    ///   - indexPath: current index path
    ///   - configure: handler for configuration
    /// - Returns: result cell
    public func dequeueReusableCell<T: UITableViewCell>(of class: T.Type,
                                                        for indexPath: IndexPath,
                                                        configure: ((T) -> Void)? = nil) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            return nil
        }
        configure?(cell)
        return cell
    }
    
    /// Returns a reusable view object for the specified reuse identifier and adds it to the table.
    /// - Parameter class: object type
    /// - Returns: result view for header or footer
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(of class: T.Type) -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.identifier)
        if let typedView = view as? T {
            return typedView
        }
        return nil
    }
    
    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    /// - Parameters:
    ///   - identifier: A string identifying the cell object to be reused. This parameter must not be nil
    ///   - indexPath: The index path specifying the location of the cell. Always specify the index path provided to you by your data source object. This method uses the index path to perform additional configuration based on the cell’s position in the table view.
    ///   - configure: The handler for configuration
    /// - Returns: Result cell
    public func genericDequeueReusableCell(of identifier: String,
                                           for indexPath: IndexPath,
                                           configure: ((UITableViewCell) -> Void)? = nil) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure?(cell)
        return cell
    }
    
    /// Set the height of the table header view
    /// - Parameter height: The height value to be set
    public func setHeightTableHeaderView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let headerView = self?.tableHeaderView else { return }
            var newFrame = headerView.frame
            newFrame.size.height = height
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                headerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
    /// Set the height of the table footer view
    /// - Parameter height: The height value to be set
    public func setHeightTableFooterView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let footerView = self?.tableFooterView else { return }
            var newFrame = footerView.frame
            newFrame.size.height = height
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                footerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
    /// Get the cell for specific row and section
    /// - Parameters:
    ///   - row: row of the cell
    ///   - section: section of the cell
    ///   - numberOfRows: number of rows
    /// - Returns: result cell
    public func cellForRow(row: Int, section: Int, numberOfRows: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: section)
        guard let cell = self.cellForRow(at: indexPath) else { return nil }
        let rowCell = row < numberOfRows - 1 ? row + 1 : row
        self.scrollToRow(at: IndexPath(row: rowCell, section: 0), at: .top, animated: false)
        return cell
    }
    
    /// Reload table view data
    /// - Parameter completion: completion handler
    public func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// Update row for specific index path with animation
    /// - Parameters:
    ///   - indexPath: current index path
    ///   - withAnimation: animation handler
    public func updateRow(at indexPath: IndexPath, withAnimation: UITableView.RowAnimation) {
        beginUpdates()
        reloadRows(at: [indexPath], with: withAnimation)
        endUpdates()
    }
    
    /// Remove row for specific index path
    /// - Parameters:
    ///   - indexPath: index path to remove the cell
    ///   - withAnimation: animation handler
    public func removeRow(at indexPath: IndexPath, withAnimation: UITableView.RowAnimation) {
        beginUpdates()
        deleteRows(at: [indexPath], with: withAnimation)
        endUpdates()
    }
    
    /// Remove the separator of the last cell
    public func setLastCellSeparatorHidden() {
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.001)))
    }
}
