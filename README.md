## ViewComparison ##

ViewComparison is a function to compare hierarchies of two views. This is useful for unit testing purposes. For instance, verifying that views hierarchy created from JSON corresponds to expected one.

The function is implemented as extension of `UIView`.

### Usage ###
- Include **UIView+Compare.swift** file to your project.

Implementation wrapped into framework for unit testing purpose. There's no need to link with the framework in real projects.

Here's example testing if layouts of two hierarchies are alike:

```swift 
XCTAssertTrue(view1.compareHierarchy(to: view2, compare: { $0.frame == $1.frame })) 
```
