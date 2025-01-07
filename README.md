# 🆙 Go-Up.nvim

"Go up" is what you used to have to say when vim wouldn't scroll up past line 1.
Now you don't have to.

## ⬆️ Video Demo

This plugin adds virtual lines _above_ line 1 of your buffers, allowing you to
scroll upwards beyond line 1.

https://github.com/user-attachments/assets/31ae6af2-c4e1-4a6a-8125-9043ba9e8c3b

### Motivation 1: Consistency

Vim allows you to scroll _downward_ until the _last_ line of your file is at the
_top_ of your window, and it allows you to scroll _upward_ until the _first_
line of your file is at the... **TOP** of your window!? Wait a minute, that
doesn't seem right. This plugin fixes that behavior and causes scrolling up and
down to behave the same, giving you a more consistent experience.

### Motivation 2: Searching

Many people like to have a mapping set such that vim centers the screen after
jumping to each search match. This is useful because as you press
<kbd>n</kbd><kbd>n</kbd><kbd>n</kbd>... you don't need to move your eyes around
the screen. Each new match is showing up right in the middle.

That's great, except when your match occurs in the first few lines of the file,
vim is unable to center the screen on that line!

This plugin fixes that behavior and allows vim to center the screen by scrolling
beyond where it would normally have scrolled. That way, every time you
center-after-search, the match will be right in the middle of the window.

### Motivation 3: Moving Things Down

Sometimes you just have a tall monitor and you're working on a 10-line file.
It's great having a tall monitor for instances when you want to look at a large
amount of context, but it's annoying that this 10-line file is crammed up at the
top of the screen. This plugin fixes that behavior by allowing you to simply
scroll until the content is positioned where you want it on the screen.

_This kind of issue comes up often in webpage design. Back in the early days,
most websites were just left-justified, leaving a large amount of blank space on
the right hand side of the screen. Nowadays, many websites center their content
and leave the blank space on both sides, rather than all on the right._

## 👆 How to Install

Lazy.nvim config:

```lua
{
    'nullromo/go-up.nvim',
    opts = {}, -- specify options here
    config = function(_, opts)
        local goUp = require('go-up')
        goUp.setup(opts)
    end,
}
```

## ⤴️ Available Functions

Go-Up provides the following functions that you can use.

| Function                          | Description                                                                                                                     | User Command       |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| `require('go-up').setup()`        | Sets up the plugin.                                                                                                             | N/A                |
| `require('go-up').centerScreen()` | Centers the current line in the middle of the window. Equivalent to the default function of `zz`.                               | N/A                |
| `require('go-up').reset()`        | Resets the plugin for the current buffer. Works by clearing all the extmarks in the Go-Up namespace, then re-initializing them. | `:GoUpReset`       |
| `require('go-up').alignTop()`     | If there are virtual lines at the top of the window, scrolls down until there aren't.                                           | `:GoUpAlignTop`    |
| `require('go-up').alignBottom()`  | If there are virtual lines at the bottom of the window, scrolls up until there aren't.                                          | `:GoUpAlignBottom` |

## 🔝 Customization

### Default Options

```lua
{
    -- affect the behavior of zz
    mapZZ = true,
}
```

### Options Table

| Option  | Data Type | Default | Description                                         |
| ------- | --------- | ------- | --------------------------------------------------- |
| `mapZZ` | boolean   | `true`  | Whether or not to affect the default `zz` behavior. |

## 📈 Other Tips

I like to center the screen with <kbd>Space</kbd>, so I use this mapping:

```lua
-- Use space to center the screen
vim.keymap.set({ 'n', 'v' }, '<space>', function()
    require('go-up').centerScreen()
end, { desc = 'center the screen' })
```

## 🔼 License, Contributing, etc.

See [LICENSE](./LICENSE) and [CONTRIBUTING.md](./CONTRIBUTING.md).

I am very open to feedback and criticism.

## ☝ Special Thanks

### Bronze Tier Sponsors

-   🥉 [collindutter](https://github.com/collindutter)
-   🏅
    [`<Your name here>`](https://github.com/nullromo/go-up.nvim/blob/main/README.md#-donating)

## ⏫ Donating

To say thanks, [sponsor me on GitHub](https://github.com/sponsors/nullromo) or
use [@Kyle-Kovacs on Venmo](https://venmo.com/u/Kyle-Kovacs). Your donation is
appreciated!
