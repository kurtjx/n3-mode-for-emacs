;;; n3-mode.el --- mode for Notation 3
;   $Id: n3-mode.el 4084 2007-12-15 17:10:13Z hugoh $

;; Copyright (c) 2003-2007 Hugo Haas <hugo@larve.net>

;; For documentation on Notation 3, see:
;; http://www.w3.org/DesignIssues/Notation3.html

;;; Comentary:

;; Goals:
;; - sytax highlighting
;; - completion
;; - indentation

;; What it does now:
;; - Syntax highlighting

;;; Code:

(require 'generic)

(define-generic-mode 'n3-mode
  ;; comment char
  (list "# ")
  ;; keywords
  (list "this" "a")
  ;; additional font-lock'ing
  '(("\\(@prefix\\)\\>" 1 font-lock-keyword-face t)
    ("\\(\\S-*?:\\)" 1 font-lock-type-face t)
    (":\\(.*?\\)[ ;.]" 1 font-lock-constant-face t)
    ("\\(<.*?>\\)" 1 font-lock-function-name-face t)
    ("\\(\\\".*?\\\"\\)" 1 font-lock-string-face t)
; Bug: some trailing characters are highlighted; restricting comments regexp
;    ("\\(#.*\\)" 1 font-lock-comment-face t)
    ("^\\s-*\\(#.*\\)" 1 font-lock-comment-face t)
    )
  ;; auto-mode
  (list "\\.n3$")
  ;; additional setup
  nil
  ;; description
  "Mode for Notation 3 documents."
  )
