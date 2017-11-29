;;; exercism-mode.el --- Exercism.io Layer functions File for Spacemacs
;; Author     : Seçkin KÜKRER
;; Created    : November 2017
;; Modified   : 2017
;; Version    : 0.0.5
;; Keywords   : exercism exercism.io exercism-mode
;; X-URL      : https://github.com/leavenha/exercism-mode
;; Last-saved : 2017-Nov-28
;;; License: MIT

;;; Commentary:
;; Implement Exercism.io features so simply.
;; [TODO "NSA Feature!"]

;;; Known Bugs:
;; [0.0.5]
;; Nothing right now.
;; [0.0.3]
;; Nothing right now.

;;; Versions:
;; [0.0.5]
;; New implementation of `fetch` command in Exercism.
;; New language definations added.
;; Seperated functions for easy maintaining in the future.
;; Works independent from file/buffer!
;; [0.0.3]
;; First public version.

;;; Code:

(defun exercism-helper/if-s|n->s (sym)
  (cond
   ((stringp sym) (if (compare-strings
                       (symbol-name (type-of sym))
                       0 5
                       "string"
                       0 5)
                      sym
                    ""))
   ((symbolp sym) "")))

(defun exercism-mode/style-given-tracks (str)
  "highlight the language names!"
  (replace-regexp-in-string "^[\s-]+\\(.+\\)[\s-]" (lambda (s) (symbol-name (type-of s))) str))

(defun exercism-mode/call-shell-command (command)
  "Run the given command in the Shell!"
  (shell-command-to-string command))

(defun exercism-mode/run-fetch-with-language (language)
  (exercism-mode/call-shell-command (concat "exercism fetch " language)))

(defun exercism-mode/send-solution-to-exercism ()
  "Send the solution to Exercism.io! This command simply send the buffer-file as a solution to Exercism.io."
  (interactive)
  (message (exercism-mode/call-shell-command (concat "exercism submit " (buffer-file-name)))))

(defun exercism-mode/fetch-new-exercise ()
  "Fetch a new exercise from Exercism.io! This command fetch new exercise based on opened buffer-file type/`extension`."
  (interactive)
  (let* ((language-name (pcase (exercism-helper/if-s|n->s (file-name-extension (exercism-helper/if-s|n->s (buffer-file-name))))
                          ("clj" "clojure")
                          ("c" "c")
                          ("cpp" "cpp")
                          ("cs" "csharp")
                          ("fs" "fsharp")
                          ("cfml" "cfml")
                          ("coffee" "coffeescript")
                          ("lisp" "common-lisp")
                          ("rpt" "crystal")
                          ("d" "d")
                          ("pas" "delphi")
                          ("go" "go")
                          ("ex" "elixir")
                          ("exs" "elixir")
                          ("elm" "elm")
                          ("hs" "haskell")
                          ("lhs" "haskell")
                          ("js" "javascript")
                          ("jl" "julia")
                          ("kt" "kotlin")
                          ("kts" "kotlin")
                          ("erl" "erlang")
                          ("lua" "lua")
                          ("cljs" "clojurescript")
                          ("java" "java")
                          )))
    (if language-name
        (message (exercism-mode/call-shell-command (concat "exercism fetch " language-name)))
      (message (exercism-mode/run-fetch-with-language
                (read-from-minibuffer (concat (exercism-mode/call-shell-command "exercism tracks")
                                              "\nSelect your programming language: ")))))))

(defun exercism-mode ()
  (interactive)
  (message "Exercism-mode Package Loaded!"))

(provide 'exercism-mode)
