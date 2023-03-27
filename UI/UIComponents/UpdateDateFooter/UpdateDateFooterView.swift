//
//  UpdateDateFooterView.swift
//  MybkMobile
//
//  Created by DucTran on 28/03/2023.
//

import UIKit

final class UpdateDateFooterView: UICollectionReusableView {

    @IBOutlet weak var dateUpdatedField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpdateDate(date: String?) {
        if let date = date {
            // convert 2023-03-20 09:00:22.0 to 20/03/2023 9:00
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            if let convertedDate = dateFormatter.date(from: date) {
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                let formattedDate = dateFormatter.string(from: convertedDate)
                dateUpdatedField.text = "Cập nhật lần cuối: \(formattedDate)"
            }
        } else {
            dateUpdatedField.text = nil
        }
    }
}
