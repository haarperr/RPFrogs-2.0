Config["Documents"]["Jobs"] = {}

Config["Documents"]["Jobs"]["police"] = {
    {
        headerTitle = "SPECIAL PERMISSION TO PARK",
        headerSubtitle = "Permission to park without limits.",
        elements = {
            { label = "holder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Surholder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "Information", type = "textarea", value = "The holder received the special permission until the end of the validity of this document.", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "WEAPON CARRYING",
        headerSubtitle = "WEAPON CARRYING of some specific weapon.",
        elements = {
            { label = "holder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Surholder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "Information", type = "textarea", value = "The holder received permission to carry weapons until the end of the validity of this document.", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "CLEAN FORM",
        headerSubtitle = "CLEAN FORM.",
        elements = {
            { label = "holder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Surholder name", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "record", type = "textarea", value = "The holder received a form in which he declares that he has a clean record valid until the end of this document.", can_be_emtpy = false, can_be_edited = false },
        },
    },
}

Config["Documents"]["Jobs"]["ems"] = {
    {
        headerTitle = "MEDICAL REPORT - PATHOLOGY",
        headerSubtitle = "Official medical report provided by a pathologist.",
        elements = {
            { label = "INSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SurINSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE MENTIONED INSURED CITIZEN HAS BEEN TESTED BY A HEALTH OFFICER AND DETERMINED HEALTHY WITH NO LONG TERM CONDITIONS DETECTED. THIS REPORT IS Valid until THE MENTIONED EXPIRATION DATE.", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "MEDICAL REPORT - PSYCHOLOGY",
        headerSubtitle = "Official medical report provided by a psychologist.",
        elements = {
            { label = "INSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SurINSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE MENTIONED INSURED CITIZEN HAS BEEN TESTED BY A HEALTH EMPLOYEE AND DETERMINED MENTALLY HEALTHY BY THE LOWEST STANDARDS OF PSYCHOLOGY. THIS REPORT IS Valid until THE MENTIONED EXPIRATION DATE.", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "MEDICAL REPORT - OPHTHALMOLOGIST",
        headerSubtitle = "Official medical report provided by an ophthalmologist.",
        elements = {
            { label = "INSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SurINSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE MENTIONED INSURED CITIZEN WAS TESTED BY A HEALTH EMPLOYEE AND DETERMINED WITH A HEALTHY AND ACCURATE VISION. THIS REPORT IS Valid until THE MENTIONED EXPIRATION DATE.", can_be_emtpy = false },
        },
    },
    {
        headerTitle = "AUTHORIZATION TO USE Marijuana",
        headerSubtitle = "Official medical marijuana use license for citizens.",
        elements = {
            { label = "INSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SurINSURED'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE MENTIONED INSURED CITIZEN IS GRANTED, AFTER BEING CAREFULLY EXAMINED BY A HEALTH SPECIALIST, PERMISSION TO USE MARIJUANA FOR UNDISCLOSED MEDICAL REASONS. THE LEGAL AND PERMITTED AMOUNT THAT A CITIZEN MAY RETAIN MAY NOT BE MORE THAN 100g.", can_be_emtpy = false, can_be_edited = false },
        },
    },
}

Config["Documents"]["Jobs"]["doj"] = {
    {
        headerTitle = "LEGAL SERVICES AGREEMENT",
        headerSubtitle = "Contract for the provision of legal services provided by a lawyer.",
        elements = {
            { label = "CITIZEN'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "SurCITIZEN'S NAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Valid until", type = "input", value = "", can_be_empty = false },
            { label = "Information", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESENTATION AND COVERAGE OF THE MENTIONED CITIZEN. THE LEGAL SERVICES ARE VALID UNTIL THE EXPIRATION DATE MENTIONED.", can_be_emtpy = false },
        },
    },
}