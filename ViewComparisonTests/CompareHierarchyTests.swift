/*
Copyright 2017 Dmytro Anokhin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import XCTest
@testable import ViewComparison


extension UIView {
    
    /// Helper initializer that sets the tag and subviews
    convenience init(tag: Int, subviews: [UIView] = []) {
        self.init(frame: .zero)
        self.tag = tag
        
        for subview in subviews {
            addSubview(subview)
        }
    }
}


class CompareHierarchyTests: XCTestCase {
    
    func testCompareEqualHierarchies() {
        // Build first hierarchy
        let view1 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 1211)
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Build second hierarchy
        let view2 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 1211)
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Validate
        XCTAssertTrue(view1.compareHierarchy(to: view2, compare: { $0.tag == $1.tag }), "Hierarchies expected to be equal")
    }
    
    func testCompareDifferentHierarchies() {
        // Build first hierarchy
        let view1 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 1211)
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Build second hierarchy
        let view2 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 1211),
                    UIView(tag: 1212) // Difference
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Validate
        XCTAssertFalse(view1.compareHierarchy(to: view2, compare: { $0.tag == $1.tag }), "Hierarchies expected to be not equal")
    }
    
    func testCompareEqualHierarchiesWithDifferentViews() {
        // Build first hierarchy
        let view1 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 1211)
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Build second hierarchy
        let view2 = UIView(tag: 1, subviews: [
            UIView(tag: 11, subviews: [
                UIView(tag: 111),
                UIView(tag: 112)
            ]),
            UIView(tag: 12, subviews: [
                UIView(tag: 121, subviews: [
                    UIView(tag: 0), // Difference
                ]),
                UIView(tag: 122)
            ])
        ])
        
        // Validate
        XCTAssertFalse(view1.compareHierarchy(to: view2, compare: { $0.tag == $1.tag }), "Hierarchies expected to be not equal")
    }
    
    func testCompareToEmptyHierarchies() {
        // Build first hierarchy
        let view1 = UIView(tag: 1, subviews: [
            UIView(tag: 11)
        ])
        
        // Build second hierarchy
        let view2 = UIView(tag: 1)
        
        // Validate
        XCTAssertFalse(view1.compareHierarchy(to: view2, compare: { $0.tag == $1.tag }), "Hierarchies expected to be not equal")
    }
    
    func testCompareEmptyHierarchies() {
        // Build first hierarchy
        let view1 = UIView(tag: 1)
        
        // Build second hierarchy
        let view2 = UIView(tag: 1)
        
        // Validate
        XCTAssertTrue(view1.compareHierarchy(to: view2, compare: { $0.tag == $1.tag }), "Hierarchies expected to be equal")
    }
}
