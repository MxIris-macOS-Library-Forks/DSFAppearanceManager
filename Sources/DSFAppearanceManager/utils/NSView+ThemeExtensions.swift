//
//  NSView+ThemeExtensions.swift
//
//  Created by Darren Ford on 23/10/20.
//  Copyright © 2022 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#if os(macOS)

import AppKit

// MARK: - Effective appearance drawing

/// Perform a block using the effective appearance settings of view
///
/// See [Discussion](https://dagronf.wordpress.com/2020/08/20/my-nscolor-colorset-colors-arent-changing-when-going-dark/)
@inlinable
public func UsingEffectiveAppearance(of view: NSView, perform block: (NSAppearance) throws -> Void) rethrows {
	if #available(macOS 11.0, *) {
		view.effectiveAppearance.performAsCurrentDrawingAppearance {
			try? block(view.effectiveAppearance)
		}
	} else {
		let saved = NSAppearance.current
		NSAppearance.current = view.effectiveAppearance
		defer {
			NSAppearance.current = saved
		}
		try block(NSAppearance.current)
	}
}

public extension NSView {
	/// Perform a block using the effective appearance settings of view
	///
	/// See [Discussion](https://dagronf.wordpress.com/2020/08/20/my-nscolor-colorset-colors-arent-changing-when-going-dark/)
	@inlinable
	func performUsingEffectiveAppearance(_ block: (NSAppearance) throws -> Void) rethrows {
		try UsingEffectiveAppearance(of: self, perform: block)
	}
}

#endif
