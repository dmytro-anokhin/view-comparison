/*
Copyright 2017 Dmytro Anokhin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import UIKit


extension UIView {

    /**
        Сompare hierarchy of the current view with hierarchy of another view.
    
        - parameters:
            - view: The view hierarchy to compare.
            - compare: The closure to compare views.
            - lhs: The view in current hierarchy.
            - rhs: The view in comparable hierarchy.
     
        - returns:
        True if hierarchies are equal.
    
        I prefer iteration over recursion. Implementation uses DFS tree traversal. Algorithm doesn't really matter if order is preserved. The choice is due to popLast function in standard library :)
    */
    public func compareHierarchy(to view: UIView, compare predicate: (_ lhs: UIView, _ rhs: UIView) -> Bool) -> Bool {
        
        var lhsStack: [UIView] = [ self ] // Stack for hierarchy of the current view
        var rhsStack: [UIView] = [ view ] // Stack for hierarchy of the comparable view
        
        repeat {
            let lhs = lhsStack.popLast()! // Pop view from the current hierarchy
            let rhs = rhsStack.popLast()! // Pop view from the comparable hierarchy
            
            if lhs.subviews.count != rhs.subviews.count { // Fail early if current and comparable hierarchies contain different number of views
                return false
            }
            
            if !predicate(lhs, rhs) {
                return false
            }
            
            // Push descendants of the current and comparable views to corresponding stacks
            lhsStack.append(contentsOf: lhs.subviews)
            rhsStack.append(contentsOf: rhs.subviews)
            
        } while !lhsStack.isEmpty && !rhsStack.isEmpty
        
        return true
    }
}
