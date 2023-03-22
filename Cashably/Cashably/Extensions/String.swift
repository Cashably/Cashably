//
//  String.swift
//  Cashably
//
//  Created by apollo on 9/17/22.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var hrefToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        let plainAttributedString = NSMutableAttributedString(string: "This is a link: ", attributes: nil)
        let string = "A link to Google"
        let attributedLinkString = NSMutableAttributedString(string: string, attributes:[NSAttributedString.Key.link: URL(string: "http://www.google.com")!])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        
        return fullAttributedString
        
    }
    var termsToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        let attributedTermsTitle = NSMutableAttributedString()
        attributedTermsTitle.append(NSAttributedString(string: "By checking this box, you agree to ", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!]))
        attributedTermsTitle.append(NSAttributedString(string: "Cashably's Terms of Service", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!, NSAttributedString.Key.link: "terms"]))
        attributedTermsTitle.append(NSAttributedString(string: " and ", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!]))
        attributedTermsTitle.append(NSAttributedString(string: "Privacy Policy,", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!, NSAttributedString.Key.link: "policy"]))
        attributedTermsTitle.append(NSAttributedString(string: ", as well as our partner ", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!]))
        attributedTermsTitle.append(NSAttributedString(string: "Dwolla's Terms of Service", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!, NSAttributedString.Key.link: "dwolla-terms"]))
        attributedTermsTitle.append(NSAttributedString(string: " and ", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!]))
        attributedTermsTitle.append(NSAttributedString(string: "Privacy Policy.", attributes: [NSAttributedString.Key.font:UIFont(name: "BRFirma-Regular", size: 12)!, NSAttributedString.Key.link: URL(string: "https://www.dwolla.com/legal/privacy/")!]))
        
        return attributedTermsTitle
        
    }
}
