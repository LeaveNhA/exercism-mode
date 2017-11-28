;;; exercism-mode.el --- Exercism.io Layer functions File for Spacemacs
;; Author     : Seçkin KÜKRER
;; Created    : November 2017
;; Modified   : 2017
;; Version    : 0.0.3
;; Keywords   : exercism exercism.io exercism-mode
;; X-URL      : https://github.com/leavenha/exercism-mode
;; Last-saved : 2017-Nov-28
;;; License: MIT

;;; Commentary:
;;; Known Bugs:
;;; Versions:
;;; Code:

(defun exercism-mode/started ()
  (interactive)
  (message "exercism-mode package loaded!"))

(defun exercism-mode/send-solution-to-exercism ()
  "Send the solution to Exercism.io! This command simply send the buffer-file as a solution to Exercism.io."
  (interactive)
  (message (shell-command-to-string (concat "exercism submit " (buffer-file-name)))))

(defun exercism-mode/fetch-new-exercise ()
  "Fetch a new exercise from Exercism.io! This command fetch new exercise based on opened buffer-file type/`extension`."
  (interactive)
  (let ((language-name (pcase (file-name-extension (buffer-file-name))
                         ("clj" "clojure")
                         ("cljs" "clojurescript")
                         ("java" "java")
                         ("el" "just-for-test"))))
    (message (shell-command-to-string (concat "exercism fetch " language-name)))))

(exercism-mode/started)

(defun exercism-mode ()
  (interactive)
  (message "Exercism-mode Package Loaded!"))
