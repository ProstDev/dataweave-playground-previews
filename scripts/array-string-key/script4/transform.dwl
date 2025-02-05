%dw 2.0
output application/json
var arr1 = [
    "key" as Key,
    "string"
]
var arr2 = [
    "key",
    "string"
]
---
[arr1, arr2] distinctBy ($ joinBy ",")