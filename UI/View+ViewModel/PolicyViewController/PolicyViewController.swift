//
//  PolicyViewController.swift
//  MybkMobile
//
//  Created by DucTran on 14/03/2023.
//

import UIKit

class PolicyViewController: UIViewController {
    
    
    @IBOutlet private weak var titleHeading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setupNavBar()
        setupPolicyLabel()
    }
    
    private func setupPolicyLabel() {
        let view = UILabel()
        view.numberOfLines = 0
        view.backgroundColor = UIColor(rgb: 0xF7F7F7)
        let text = """
                <ol>
                    <li>
                        Mybk Mobile không phải là ứng dụng chính thức của trường Đại học Bách Khoa - ĐHQG TP.HCM và không có bất cứ liên quan gì đến ban quản lý, cán bộ trường. Mybk Mobile không chịu trách nhiệm cho việc bạn trễ giờ học, quên đi học hay trễ giờ thi, quên đi thi.
                    </li>
                    <li>
                        Mybk Mobile không lưu trữ bất kỳ thông tin nào của bạn ở trên internet. Mọi dữ liệu của bạn đều được lưu trữ ở trên điện thoại và chỉ ở trên điện thoại. Thông tin đăng nhập của bạn được mã hóa và bảo vệ bởi hệ điều hành. Tuy nhiên, Mybk Mobile không chịu trách nhiệm cho các sự cố liên quan về tài khoản Mybk của bạn (chẳng hạn như bị mất tài khoản do hacker, hay do cài đặt và sử dụng các phiên bản Mybk Mobile đã bị chỉnh sửa, v.v.).
                    </li>
                </ol>
                """
        let attributeText = try? NSMutableAttributedString(data: text.data(using: .unicode)!,
                                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                                           documentAttributes: nil)
        let textRange = NSRange(location: 0, length: attributeText?.length ?? 0)
        attributeText?.addAttribute(.foregroundColor, value: UIColor(rgb: 0x11425E), range: textRange)
        attributeText?.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: textRange)
        let str = NSString(string: attributeText?.string ?? "")
        attributeText?.addAttribute(.font,
                                    value: UIFont.systemFont(ofSize: 15, weight: .bold),
                                    range: str.range(of: "không phải"))
        view.attributedText = attributeText
        self.view.addSubview(view)
        view.setConstrain(to: self.view) { make in
            make.append(.leading(leading: 20))
            make.append(.trailing(trailing: 20))
        }
        view.topAnchor.constraint(equalTo: titleHeading.bottomAnchor, constant: 20).isActive = true
        
    }
    
    @IBAction func backHandler(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.popViewController(animated: true)
    }
}
