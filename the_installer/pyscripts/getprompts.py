import json

def generate_prompts(data):
    keys = data["keys"]
    headers = data["headers"]
    prompts = {}

    for key in keys:
        key_prompts = []
        for header in headers:
            key_prompts.append(f"For {key} can you tell me what the {header} are? if invalid question respond with NA")
        prompts[key] = key_prompts

    return prompts

def main():
    data = {
        "keys": [
        "Python",
        "Golang",
        "Java",
        "C++",
        "C#",
        "Node",
        "Ruby",
        "NMAP",
        "Metasploit",
        "Wireshark",
        "NPM",
        "Git",
        "Docker",
        "WSL",
        "Chrome",
        "Firefox",
        "Tor",
        "Youtube-dl",
        "VLC",
        "7zip",
        "Vim",
        "Sublime",
        "VSCode",
        "GithubDesktop",
        "Spotify",
        "Discord",
        "Zoom",
        "Slack",
        "Steam",
        "OBS",
        "Gimp",
        "Inkscape",
        "Blender",
        "Unity",
        "Godot",
        "AndroidStudio",
        "IntelliJ",
        "PyCharm",
        "WebStorm",
        "Rider",
        "Firebasecli",
        "Heroku",
        "Vercel",
        "Netlify",
        "PMP",
        "Yarn",
        "nvm",
        "Chocolatey",
        "Homebrew",
        "Terraform",
        "Brave",
        "ChromeDriver",
        "FirefoxDriver",
        "Selenium",
        "Postman",
        "Insomnia",
        "googlecloudsdk",
        "awscli",
        "azure-cli",
        "kubectl",
        "helm",
        "minikube"
        ],
        "headers": [
        "dependencies",
        "post_install_commands",
        "post_install_commands_mac",
        "install_commands_mac",
        "description",
        "update_command",
        "install_commands_windows",
        "tags",
        "newest_version",
        "isdesktop",
        "package_manager",
        "config_instructions",
        "post_install_commands_windows",
        "url",
        "potential_packages",
        "verified",
        "post_install_commands_linux",
        "run_command",
        "uses",
        "install_commands_linux",
        "AllowedOS",
        "isnpm",
        "current_version_command",
        "version",
        "setup_guide",
        "package_manager_install_commands"
        ]
    }

    prompts = generate_prompts(data)
    
    with open('C:/Users/ericd/Desktop/scripts/the_installer/prompts.json', 'w') as f:
        json.dump(prompts, f, indent=4)

    for key, value in prompts.items():
        print(f"{key}:")
        for prompt in value:
            print(f"\t{prompt}")

if __name__ == "__main__":
    main()
