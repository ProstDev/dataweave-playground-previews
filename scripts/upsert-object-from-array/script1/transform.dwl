%dw 2.0
output application/json 
var users = [
    {
        id: 1,
        name: "alex1",
        notes: "NA"
    },
    {
        id: 2,
        name: "alex2",
        notes: "NA"
    },
    {
        id: 3,
        name: "alex3",
        notes: "NA"
    }
]
var updateUser = {
    id: 2,
    notes: "this is my new note",
    newField: "abc"
}
---
users map ((user) -> 
    if (user.id ~= updateUser.id) ???
    else user
)