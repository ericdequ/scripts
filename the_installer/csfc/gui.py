import json

data = [
    {
        "name": "CISA's Cybersecurity Assessment Framework",
        "description": "A comprehensive set of tools and resources that can be used to assess an organization's cybersecurity posture. The CSF includes a self-assessment questionnaire, as well as guidance on how to implement the controls identified in the questionnaire.",
    },
    {
        "name": "NIST Special Publication 800-53",
        "description": "A set of security controls that are recommended for federal government agencies. NIST SP 800-53 can be used as a starting point for developing an organization's own security controls.",
    },
    {
        "name": "SANS Institute's Critical Security Controls",
        "description": "A set of 20 security controls that are considered to be essential for protecting information systems. The CSC can be used to assess an organization's cybersecurity posture and to develop a plan to implement the controls identified in the CSC.",
    },
    {
        "name": "The OpenSAMM Project",
        "description": "A free and open-source framework that can be used to assess an organization's cybersecurity posture. The OpenSAMM Project includes a self-assessment questionnaire, as well as guidance on how to implement the controls identified in the questionnaire.",
    },
]

with open("frameworks.json", "w") as outfile:
    json.dump(data, outfile, indent=4)
