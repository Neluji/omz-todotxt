# Todo.txt plugin

> Some aliases for `todo.txt` CLI tool, `todo.sh`

To use it, add `todo.txt` to the plugins array in your zshrc file:

```zsh
plugins=(... todo.txt)
```

## Aliases

| Alias    | Command                      | Description                         |
| -------- | ---------------------------- | ----------------------------------- |
| `todo`   | `todo.sh`                    | Short for the tool                  |
| `todoa`  | `todo add <item-text>`       | Adds a new item                     |
| `todod`  | `todo do <item>`             | Marks an item as done               |
| `todor`  | `todo del <item>`            | Removes an item                     |
| `todol`  | `todo listpri`               | Lists all items, sorted by priority |
| `todolp` | `todo listproj`              | Lists projects                      |
| `todop`  | `todo pri <item> <priority>` | Prioritizes an item                 |
