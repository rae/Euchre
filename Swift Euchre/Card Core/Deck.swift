//
//  Deck.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Deck: CardCollection {
	
	// Make Deck
	var collective = [Card]()
	convenience required init() {
		self.init()
	}
	init(_ lowRank: Int, _ highRank: Int, number: Int?=1) {
		for _ in 1...number! {
			for suit in 1...4 {
				for rank in lowRank...highRank {
					collective.append(Card(rnk: rank, sut: suit))
				}
			}
		}
	}
	convenience init(lowRank: Rank, highRank: Rank, number: Int?=1) {
		self.init(lowRank.rawValue, highRank.rawValue, number: number)
	}
	
	// Deal
	func deal(hands: [Hand], var kitty: Hand?=nil, deadSize: Int?=0) {
		collective.shuffleInPlace()
		guard deadSize < self.count  else {
			print("No cards dealt, as reserved card count (\(deadSize)) is more than the deck size (\(self.count)).")
			return
		}
		// Set aside a guaranteed number of cards that will not be dealt
		let loc = deadSize
		// Give all players an equivalent number of cards
		while self.count-deadSize! >= hands.count {
			for var hand in hands {
				// is there a way to treat self like hand and use it as a var instead of a let?
				hand.append(self.collective.removeAtIndex(loc!))
			}
		}
		// Shove the remaining cards into the kitty (if provided)
		guard kitty != nil else { return }
		for 🎴 in deck {
			kitty?.append(🎴)
		}
	}
	
	// Since Swift does not yet have splats
	/*func deal(hands: Hand..., kitty: Hand?, deadSize: Int?) {
		deal(hands, kitty: kitty, deadSize: deadSize)
	}*/ // can't even use this anyway, since trying to do so causes the compiler to segfault 11
}

// Dislpay a deck
extension Deck: CustomStringConvertible {
	var description: String {
		let lines = 4
		let number = self.count / lines
		var out = ""
		for line in 0..<lines {
			for pos in 0..<number {
				out += self[line*number + pos].shortName()
				out += " "
			}
			out += "\n"
		}
		return out
	}
}

func makeEuchreDeck(number: Int?=1) -> Deck {
	return Deck.init(lowRank: (Rank).Nine, highRank: (Rank).HiAce, number: number!)
}

func makeDoubleEuchreDeck() -> Deck {
	return makeEuchreDeck(2)
}

func makePinochleDeck() -> Deck {
	return makeDoubleEuchreDeck()
}

func makeStandardDeck() -> Deck {
	return Deck.init(lowRank: (Rank).Two, highRank: (Rank).HiAce)
}