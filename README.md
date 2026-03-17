# gkey 🔐
**gkey** 🔐 is a collection of automation scripts designed to make your Git workflow faster ⚡️ and easier 😌. If you use multiple GitHub :octocat: accounts or work with different SSH keys 🔑🔑, gkey helps you manage them automatically.

## Main Features:

- **Automatic Account Switching:** It identifies the correct SSH Host based on your GitHub username.

- **Smart Cloning:** It simplifies the git clone process by using custom aliases.

- **Easy Installation:** It includes a professional script that detects your Operating System (Linux, macOS, or Windows) and configures everything for you.

- **Profile Integration:** It automatically adds shortcuts to your terminal (Bash or ZSH) so you can start working immediately.

This tool is perfect for developers who want to avoid permission issues and save time when managing repositories.

## Requirements
The only configuration you need is in your **.ssh/config** file. You must add a User property to each **Host** with **the GitHub username**. This is important because **gkey 🔐** uses this name to find the correct Host and **SSH key** for your **GitHub URLs.**

``` yaml
# .ssh/config

# configuration personal
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/personal/key_personal
    user <your_user> # <------ add this property

# configuration auxiliar
Host github.com-auxiliar
    HostName github.com
    User git
    IdentityFile ~/.ssh/auxiliar/key_auxiliar
    user <your_user> # <------ add this property

```

## How to use gkey 🔐
Follow these simple steps to start using the suite.

***Step 1: update your SSH config***

Open your `~/.ssh/config` file and add the user property to your Hosts.

Example: 
```yaml
 # configuration auxiliar
 Host github.com-auxiliar
 HostName github.com
 User git
 IdentityFile ~/.ssh/auxiliar/key_auxiliar
 user <your_user> # <------ add this property
```

***Step 2: Clone and Enter to Project***

1. Clone the repository First, download the project to your local machine.
2. Enter the project folder Navigate to the directory you just created:
`cd gkey`


***Step 3: Run the Installer***

Open your terminal and run the installation script. this will configure the commands and aliases for you.
    
```bash
bash install.sh
```

***Step 4: Restart your Terminal***

Close your terminal and open it again, or run the source command to apply the changes.

```bash
source ~/.zshrc # or ~/.bashrc
```

***Step 5: Use the Commands**

Now you can use the new shortcuts! To clone a repository using a especific GitHub user, just type:

```bash
gclone [repository_url]

gremote [repository_url] [origin_name] # origin_name is optional.

gremoteset [repository_url] [origin_name] # origin_name is optional.

glsremote [repository_url]
```
---

## 💡 Extra Resources
If you don't know how to set up multiple SSH keys, you can follow this tutorial: [link tutorial at Dev.to](https://dev.to/chema/como-usar-varias-ssh-keys-para-diferentes-repositorios-de-github-o-gitlab-e58)
