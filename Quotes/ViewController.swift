//
//  ViewController.swift
//  Quotes
//
//  Created by Matthew Curran on 4/2/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuoteDelegate {
    
    let quoteFetcher = QuoteFetcher()

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet var newQuoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newQuoteButton.setTitle("Fetching...", for: .disabled)
        newQuoteButton.isEnabled = false
        
        quoteFetcher.quoteDelegate = self
        quoteFetcher.fetchRandomQuote()
    }
    
    func quoteFetched(quote: Quote) {
        DispatchQueue.main.async {
            
            let quoteText = "\(quote.text) - \(quote.author)"
            let data = Data(quoteText.utf8)
            
            let attributedString = try? NSAttributedString(
                data: data,
                options:
                [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue ],
                documentAttributes: nil)
            
            self.quoteTextView.attributedText = attributedString
            self.newQuoteButton.isEnabled = true
        }
    }
    
    func quoteFetchError(because quoteError: QuoteError) {
        let alert = UIAlertController(title: "Error", message: "Error fetching quote \(quoteError.message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
        newQuoteButton.isEnabled = true
        //print(quoteError)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newQuoteButtonTapped(_ sender: Any) {
        newQuoteButton.isEnabled = false
        quoteFetcher.fetchRandomQuote()
    }
    
}

