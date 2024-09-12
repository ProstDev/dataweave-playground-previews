%dw 2.0
output application/json skipNullOn="everywhere"
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
    notes: "this is my new note"
}
---
users map ((user) -> 
    if (user.id ~= updateUser.id) user update {
        case na at .name -> updateUser.name default na
        case no at .notes -> updateUser.notes default no
        case nf at .newField! -> updateUser.newField default nf
    } else user
)