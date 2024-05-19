# git

Config:

```toml
# multiple gitconfig
[includeIf "gitdir:~/Project/<path>"]
  path = ~/.gitconfig_<project_name>

# merge tool
[merge]
  tool = nvim
[mergetool "nvim"]
  cmd = nvim -c "DiffviewOpen"
[mergetool]
  prompt = false
```
