# Todo.txt plugin

> Some aliases for `todo.txt` CLI tool, `todo.sh`

To use it, first clone this repo in `todo.txt` in your `$ZSH_CUSTOM/plugins` folder (default to `~/.oh-my-zsh/custom` :
```zsh
git clone https://github.com/Neluji/omz-todotxt ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/todo.txt
```
Then add `todo.txt` to the plugins array in your zshrc file:

```zsh
plugins=(... todo.txt)
```

## Aliases

| Alias    | Command                      | Description                            |
| -------- | ---------------------------- | -------------------------------------- |
| `todo`   | `todo.sh`                    | Short for the tool                     |
| `todoa`  | `todo add <item-text>`       | Adds a new item                        |
| `todod`  | `todo do <item>`             | Marks an item as done                  |
| `todor`  | *custom*                     | Removes one or more item(s)            |
| `todol`  | `todo listpri`               | Lists all items, sorted by priority    |
| `todolp` | `todo listproj`              | Lists projects                         |
| `todop`  | `todo pri <item> <priority>` | Prioritizes an item                    |
| `todostx`| *custom*                     | Prints a reminder on todo.txt's syntax |
