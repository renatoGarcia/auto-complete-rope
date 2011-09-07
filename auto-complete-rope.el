;;; auto-complete-rope.el --- Auto Completion source for rope for GNU Emacs

;; Copyright (C) 2011 Renato Florentino Garcia

;; Author: Renato Florentino Garcia <fgar.renato@gmail.com>
;; Keywords: completion, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; An auto-complete source using the Python Rope library

;;; Code:

(require 'auto-complete)

(defun ac-rope-candidates ()
  (setq ac-prefix (substring ac-prefix 1))
  (setq ac-point (+ 1 ac-point))
  (mapcar (lambda (comp)
            (concat ac-prefix comp)) (rope-completions)))

(defun ac-rope-prefix()
  (save-excursion
    (re-search-backward "[^[:alnum:]_]")))

(defun ac-rope-document (item)
  (let ((oldbuf (current-buffer))
        (oldpoint (point)))
    (set-buffer (get-buffer-create "*auto-complete-rope-doc*"))
    (erase-buffer)
    (insert-buffer-substring oldbuf)
    (delete-region ac-point oldpoint)
    (goto-char ac-point)
    (insert item)
    (or (rope-get-doc) "  ")))

(defvar ac-source-rope
  '((candidates . ac-rope-candidates)
    (prefix . ac-rope-prefix)
    (document . ac-rope-document)))

(provide 'auto-complete-rope)