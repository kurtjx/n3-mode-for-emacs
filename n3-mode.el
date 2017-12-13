;;; n3-mode.el --- mode for Notation 3

;; Original work by 2003-2007 Hugo Haas <hugo@larve.net>
;; re-worked and re-published by kurtjx (c) 2010 <kurtjx@gmail.com>

;; For documentation on Notation 3, see:
;; http://www.w3.org/DesignIssues/Notation3.html

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU GPL see http://www.gnu.org/licenses.

;;; Comentary:

;; Goals:
;; - sytax highlighting
;; - completion
;; - indentation

;; What it does now:
;; - Syntax highlighting
;; - comment/uncomment block with M-;

;;; Code:

;; the command to comment/uncomment text
(defun n3-comment-dwim (arg)
"Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
   (interactive "*P")
   (require 'newcomment)
   (let ((deactivate-mark nil) (comment-start "#") (comment-end ""))
     (comment-dwim arg)))

(setq n3-highlights
  '(("\\(@prefix\\)\\>" 1 font-lock-keyword-face t)
    ("\\(a\\)\\>" 1 font-lock-keyword-face t)
    ("\\(\\S-*?:\\)" 1 font-lock-type-face t)
    (":\\(.+?\\)[ ;.]" 1 font-lock-constant-face t)
    ("\\(<.*?>\\)" 1 font-lock-function-name-face t)
    ("\\(\\\".*?\\\"\\)" 1 font-lock-string-face t)
    ; Bug: some trailing characters are highlighted; restricting comments regexp
    ; ("\\(#.*\\)" 1 font-lock-comment-face t)
    ("^\\s-*\\(#.*\\)" 1 font-lock-comment-face t)
    )
)

;;(define-generic-mode 'n3-mode
(define-derived-mode n3-mode fundamental-mode "n3-mode"
  ;; setup tab key not working :/
  ;;(setq c-basic-offset 4)

  ;; syntax highlighting
  (setq font-lock-defaults '(n3-highlights))

  ;; modify the keymap M-; comments/uncomments region
  (define-key n3-mode-map [remap comment-dwim] 'n3-comment-dwim)
  ;; comments: “# ...” 
  (modify-syntax-entry ?# "< b" n3-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" n3-mode-syntax-table)

  ;; description
  "Mode for Notation 3 documents."
)
