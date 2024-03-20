%dw 2.0
output application/json
import time from dw::util::Timer
var items = (1 to 10000) as Array map {
    id: $$,
    criteria: randomInt(100),
    yearOfBirth: 1900 + randomInt(123)
}
fun mapAndFilter() = 
    items map {
        ($),
        isValid: $.criteria < 50, // needed for filter
        additionalField: "something",
        years: now().year - $.yearOfBirth
    } filter ($.isValid)
fun onlyReduce() = items reduce (item, acc=[]) ->
    if (item.criteria < 50)
        acc + {
            (item),
            isValid: item.criteria < 50, // can be removed
            additionalField: "something",
            years: now().year - item.yearOfBirth
        }
    else acc
fun filterAndMap() =
    items filter ($.criteria < 50) map {
        ($),
        isValid: $.criteria < 50, // can be removed
        additionalField: "something",
        years: now().year - $.yearOfBirth
    }
---
{
    mapAndFilter: time(() -> mapAndFilter()) then $.end - $.start,
    onlyReduce: time(() -> onlyReduce()) then $.end - $.start,
    filterAndMap: time(() -> filterAndMap()) then $.end - $.start
} 
mapObject ((value, key, index) -> 
    (key): (value as String)[2 to -2] as Number
) orderBy $