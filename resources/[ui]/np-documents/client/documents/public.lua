Config["Documents"]["public"] = {
    {
        headerTitle = "DECLARATION OF TRUTH",
        headerSubtitle = "Citizen's declaration of veracity.",
        elements = {
            { label = "CONTENT OF THE DECLARATION", type = "textarea", value = "", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "WITNESS WITNESS",
        headerSubtitle = "official testimony.",
        elements = {
            { label = "DATE OF OCCURRENCE", type = "input", value = "", can_be_emtpy = false },
            { label = "CONTENT TESTIMONY", type = "textarea", value = "", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "VEHICLE TRANSFER DECLARATION",
        headerSubtitle = "VEHICLE TRANSFER DECLARATION to another citizen.",
        elements = {
            { label = "PLATE NUMBER", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "AGREED PRICE", type = "input", value = "", can_be_empty = false },
            { label = "OTHER INFORMATION", type = "textarea", value = "", can_be_emtpy = true },
        },
    },
    {
        headerTitle = "DECLARATION OF DEBT TO CITIZENS",
        headerSubtitle = "official debt statement to another citizen.",
        elements = {
            { label = "CREDITOR NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SURCREDITOR NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "OVERVALUE DUE", type = "input", value = "", can_be_empty = false },
            { label = "DUE DATE", type = "input", value = "", can_be_empty = false },
            { label = "OTHER INFORMATION", type = "textarea", value = "", can_be_emtpy = true },
        },
    },
    {
        headerTitle = "DEBT SETTLEMENT STATEMENT",
        headerSubtitle = "Declaration of debt discharge from another citizen.",
        elements = {
            { label = "DEBTOR'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "DEBTOR'S SURNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALUE OF DEBT", type = "input", value = "", can_be_empty = false },
            { label = "OTHER INFORMATION", type = "textarea", value = "I DECLARE THAT THE MENTIONED CITIZEN MADE A PAYMENT WITH THE MENTIONED DEBT VALUE", can_be_emtpy = false, can_be_edited = false },
        },
    },
}