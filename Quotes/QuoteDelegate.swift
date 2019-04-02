//
//  QuoteDelegate.swift
//  Quotes
//
//  Created by Matthew Curran on 4/2/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation

protocol QuoteDelegate {
    func quoteFetched(quote: Quote)
    func quoteFetchError(because quoteError: QuoteError)
}
