# learn-lisp

## INSTALL

[[http://www.jonathanfischer.net/modern-common-lisp-on-linux/]]


## hello world

* lisp调试器中，q退出
* 快速加载文件 fast-load file (fasl)

```lisp
(load "p0-hello-world.lisp")
(load (compile-file "p0-hello-world.lisp"))
```

## simple database

* list 列表
* plist, property list 属性表
  * getf
* defun 定义函数
* defvar 定义变量
* push
* 全局变量约定名字包含星号 `*db*`
  * `*standard-output*`
  * `*query-io*`
* format
  * `~a` output one var
  * `~t` `~10t` tab
  * `~{ ~}` list
  * `~%` new line

读取
* force-output 不等待换行 maybe
* read-line read
* parse-integer
* or宏 not
* y-or-n-p函数
* loop
* return
  * `(defun loop-test () (loop (if (not (parse-integer (read-line *query-io*) :junk-allowed t)) (return))))`

保存
* with-open-file宏
* with-standard-io-syntax
* print 打印成可以被Lisp读取器读回的形式
* `(setf *db* nil)` 赋值

查询
* remove-if-not
  * `#'` 获取函数 `#'evenp`
  * lambda `#'(lambda (x) (= 0 (mod x 2)))`
  * equal
* 关键字形参
  * `(defun foo (&key a b c) (list a b c))`
  * `(foo :a 1 :c 3)`
* mapcar列表映射
* when
* funcall

消除重复
* reverse
* defmacro
  * `'` `\`` `,`
    * `'(1 2 3)`
    * `\`(1 2 (+ 1 2))`
    * `\`(1 2 ,(+ 1 2))`
  * loop
    * while
    * collecting
    * pop
* &rest任意数量实参  &key
* `macroexpand-1`展开宏


```lisp
(list 1 2 3)

; property list plist
(list :a 1 :b 2 :c 3)

(getf (list :a 1 :b 2 :c 3) :a)
(setf *db* nil)

(remove-if-not #'evenp '(1 2 3 4 5 6))
(remove-if-not #'(lambda (x) (= 1 (mod x 2))) '(1 2 3 4 5 6))
```

[[p1-cd-database.lisp]]


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
| ~C-c C-q~ C-c C-] | 补全闭括号 |
| C-c C-k | 编译并加载当前buffer所关联的文件 |
| C-x C-f | 新建文件 |
| C-x C-s | 保存文件save-buffer |
| C-c C-c | slime-compile-defun 编译求值当前行 |

* 其他需求
  * 重复之前的某一条命令
  * 删除到行首，上一行末尾
  * 删除行，粘贴行



```
,cd dir
```

# learn lisp

