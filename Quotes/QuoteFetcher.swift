//
//  QuoteFetcher.swift
//  Quotes
//
//  Created by Matthew Curran on 4/2/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation

class QuoteError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class QuoteFetcher {
    
    var quoteDelegate: QuoteDelegate?
    
    let urlString = "https://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1"
    
    func fetchRandomQuote() {
        
        guard let delegate = quoteDelegate else {
            print("Warning - no delegate set.")
            return
        }
        
        let url = URL(string: urlString)
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let error = error {
                delegate.quoteFetchError(because: QuoteError(message: error.localizedDescription))
            }
            
            if let quoteData = data {
                let decoder = JSONDecoder()
                if let quote = try? decoder.decode([Quote].self, from: quoteData) {
                    if let randomQuote = quote.first {
                        delegate.quoteFetched(quote: randomQuote)
                    } else {
                        delegate.quoteFetchError(because: QuoteError(message: "No quotes returned"))
                    }
                } else {
                    delegate.quoteFetchError(because: QuoteError(message: "Unable to decode server response."))
                }
            }
            

            
            // TODO: handle errors
            
        })
        task.resume()
    }
}
