# ConstraintsApplier
Lightweight extensions to simplify Auto Layout usage.

## Examples

### from:

```swift
container.addsubview(topLeading)
container.addsubview(bottomTrailing)

topLeading.translatesAutoresizingMaskIntoConstraints = false
bottomTrailing.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    topLeading.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
    topLeading.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
    topLeading.widthAnchor.constraint(equalToConstant: 30),
    topLeading.heightAnchor.constraint(equalToConstant: 40),
    
    bottomTrailing.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
    bottomTrailing.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10),
    bottomTrailing.widthAnchor.constraint(equalTo: topLeading.widthAnchor),
    bottomTrailing.heightAnchor.constraint(equalTo: topLeading.heightAnchor),
])
```
### to:

```swift
container.addsubviews(
    topLeading
        .top(to: container.top, 10)
        .leading(to: container.leading, 20)
        .width(to: 30)
        .height(to: 40),
    
    bottomTrailing
        .bottom(to: container.bottom, 10)
        .trailing(to: container.trailing, 10)
        .width(to: topLeading.width)
        .height(to: topLeading.height)
)
```
