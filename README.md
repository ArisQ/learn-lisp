# learn-lisp

## hello world

* lisp调试器中，q退出
* 快速加载文件 fast-load file (fasl)

```lisp
(load "p0-hello-world.lisp")
(load (compile-file "p0-hello-world.lisp"))
```


## emacs shortcuts

| command | meaning |
| C-h t | tutorial |
| C-h i | info |
| C-h ? | 帮助列表 |
| C-h k | 组合键含义 |
| C-h w | 查找组合键 |
| C-x b | 切换buffer |
| C-c C-z | 编辑lisp文件时，切换到lisp交互的buffer |
| C-c C-l | 编辑lisp buffer时，调用slime-load-file加载文件 |
| C-c C-k | 编译并加载当前buffer所关联的文件 |
| C-x C-f | 新建文件 |
| C-x C-s | 保存文件save-buffer |
| C-x C-q | slime-close-parens-at-point |
| C-c C-c | slime-compile-defun |

* 其他需求
  * 重复之前的某一条命令
  * 删除到行首，上一行末尾
  * 删除行，粘贴行



```
,cd dir
```