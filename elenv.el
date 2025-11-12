;;; elenv.el --- Environment variable management  -*- lexical-binding: t; -*-

;; Copyright (C) 2022-2025  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs-elpa/elenv
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (msgu "0.1.0") (s "1.12.0") (list-utils "0.4.6"))
;; Keywords: maint

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; The package name `elenv' stands for Emacs Lisp environment.
;;
;; Environment variable management.
;;

;;; Code:

;;
;;; Compiler pacifier

(declare-function s-blank-str-p "ext:s.el")

;;
;;; OS

;;;###autoload
(defconst elenv-windows (memq system-type '(cygwin windows-nt ms-dos))
  "The operating system is Microsoft Windows compatible.")

;;;###autoload
(defconst elenv-darwin (eq system-type 'darwin)
  "The operating system is GNU-Darwin compatible.")

;;;###autoload
(defconst elenv-macos elenv-darwin
  "The operating system is macOS compatible.")

;;;###autoload
(defconst elenv-linux (eq system-type 'gnu/linux)
  "The operating system is Linux compatible.")

;;;###autoload
(defconst elenv-bsd (eq system-type 'gnu/kfreebsd)
  "The operating system is BSD compatible.")

;;;###autoload
(defconst elenv-unix (memq system-type '(aix berkeley-unix hpux usg-unix-v))
  "The operating system is Unix compatible.")

;;;###autoload
(defconst elenv-system-type
  (cond (elenv-windows 'dos)
        (elenv-macos   'mac)
        (elenv-linux   'unix)
        (elenv-bsd     'bsd)
        (t             'unknown))
  "Generic system type.")

;;;###autoload
(defmacro elenv-with-os (os &rest body)
  "Evaluate BODY by OS."
  (declare (indent 1))
  `(when (or (eq system-type ,os) (memq system-type ,os)) ,@body))

;;;###autoload
(defmacro elenv-with-windows (&rest body)
  "Evaluate BODY in Windows."
  (declare (indent 0)) `(when elenv-windows ,@body))

;;;###autoload
(defmacro elenv-with-macos (&rest body)
  "Evaluate BODY in macOS."
  (declare (indent 0)) `(when elenv-macos ,@body))

;;;###autoload
(defmacro elenv-with-linux (&rest body)
  "Evaluate BODY in Linux."
  (declare (indent 0)) `(when elenv-linux ,@body))

;;;###autoload
(defmacro elenv-with-bsd (&rest body)
  "Evaluate BODY in BSD."
  (declare (indent 0)) `(when elenv-bsd ,@body))

;;;###autoload
(defmacro elenv-with-unix (&rest body)
  "Evaluate BODY in Unix."
  (declare (indent 0)) `(when elenv-unix ,@body))

;;
;;; Environment

;;;###autoload
(defmacro elenv-if-env (variable then &rest else)
  "Evaluate THEN if VARIABLE is valid, we execute ELSE if not valid."
  (declare (indent 1))
  `(if-let ((value (getenv ,variable))) ,then ,@else))

;;;###autoload
(defmacro elenv-when-env (variable &rest body)
  "Evaluate BODY when VARIABLE is valid."
  (declare (indent 1))
  `(when-let ((value (getenv ,variable))) ,@body))

;;;###autoload
(defmacro elenv-unless-env (variable &rest body)
  "Evaluate BODY when VARIABLE is valid."
  (declare (indent 1))
  `(unless (getenv ,variable) ,@body))

;;
;;; Executable

(defmacro elenv--exec-find (command remote)
  "Find executable COMMAND.

For argument REMOTE, see function `executable-find' description."
  (let ((var (intern (format "elenv-exec-%s%s" command (if remote "-remote" "")))))
    `(if (boundp ',var)
         (symbol-value ',var)
       (defvar ,var (executable-find ,command ,remote)
         (format "Variable generate it with `elenv' finding executable `%s'."
                 ,command))
       (symbol-value ',var))))

;;;###autoload
(defmacro elenv-if-exec (command remote then &rest else)
  "Evaluate body (THEN and ELSE) if COMMAND is found.

For argument REMOTE, see function `executable-find' description."
  (declare (indent 3))
  `(if-let ((value (elenv--exec-find ,command ,remote)))
       ,then
     ,@else))

;;;###autoload
(defmacro elenv-when-exec (command remote &rest body)
  "Evaluate BODY when COMMAND is found.

For argument REMOTE, see function `executable-find' description."
  (declare (indent 2))
  `(when-let ((value (elenv--exec-find ,command ,remote)))
     ,@body))

;;;###autoload
(defmacro elenv-unless-exec (command remote &rest body)
  "Evaluate BODY unless COMMAND is found.

For argument REMOTE, see function `executable-find' description."
  (declare (indent 2))
  `(unless (elenv--exec-find ,command ,remote)
     ,@body))

;;
;;; Graphic

;;;###autoload
(defconst elenv-graphic-p (display-graphic-p)
  "Return t if graphic mode.")

;;;###autoload
(defun elenv-monitor-pixel-width (&optional frame)
  "Return the pixel width from physical monitor by FRAME."
  (nth 3 (assq 'geometry (frame-monitor-attributes frame))))

;;;###autoload
(defun elenv-monitor-pixel-height (&optional frame)
  "Return the pixel height from physical monitor by FRAME."
  (nth 4 (assq 'geometry (frame-monitor-attributes frame))))

;;;###autoload
(defun elenv-monitor-vertical-p ()
  "Return non-nil if currently on a vertical display."
  (< (elenv-monitor-pixel-width) (elenv-monitor-pixel-height)))

;;;###autoload
(defun elenv-monitor-horizontal-p ()
  "Return non-nil if currently on a horizontal display."
  (not (elenv-monitor-vertical-p)))

;;
;;; Daemon

;;;###autoload
(defconst elenv-daemon-p (daemonp)
  "Return t if daemon mode.")

;;
;;; Debugging

;;;###autoload
(defun elenv-debugging-p ()
  "Return non-nil when debugging."
  (bound-and-true-p edebug-active))

;;
;;; Display

;;;###autoload
(defmacro elenv-with-no-redisplay (&rest body)
  "Execute BODY without any redisplay execution."
  (declare (indent 0) (debug t))
  `(let ((inhibit-redisplay t)
         (inhibit-modification-hooks t)
         after-focus-change-function
         buffer-list-update-hook
         display-buffer-alist
         window-configuration-change-hook
         window-scroll-functions
         window-size-change-functions
         window-state-change-hook)
     ,@body))

;;
;;; Type

;;;###autoload
(defun elenv-types (obj)
  "Return a list of symbol representing the type of OBJ."
  (delete-dups
   (cl-remove-if #'null
                 (list (and (integerp obj) 'integer)
                       (and (integerp obj) 'integer)
                       (and (floatp obj) 'float)
                       (and (numberp obj) 'number)
                       (and (consp obj) 'cons)
                       (and (characterp obj) 'character)
                       (and (stringp obj) 'string)
                       (and (listp obj) 'list)
                       (and (vectorp obj) 'vector)
                       (and (char-table-p obj) 'char-table)
                       (and (hash-table-p obj) 'hash-table)
                       (and (recordp obj) 'record)
                       (and (functionp obj) 'function)
                       (and (macrop obj) 'macro)
                       (and (symbolp obj) 'symbol)
                       (type-of obj)))))

;;;###autoload
(defun elenv-type-of (obj)
  "Return a symbol representing the type of OBJ."
  (car (elenv-types obj)))

;;
;;; Color

(defun elenv-light-color-p (hex-code)
  "Return non-nil if HEX-CODE is in light tone."
  (when elenv-graphic-p
    (let ((gray (nth 0 (color-values "gray")))
          (color (nth 0 (color-values hex-code))))
      (< gray color))))

;;
;;; List

;;;###autoload
(defmacro elenv-push (newelt seq)
  "Push NEWELT to the ahead or back of SEQ."
  `(if (zerop (length ,seq))
       (push ,newelt ,seq)
     (list-utils-insert-after-pos ,seq (max (1- (length ,seq)) 0) ,newelt)))

;;;###autoload
(defmacro elenv-uappend (place new-items)
  "Like the function `'append`' but destructive, preserving order
and avoiding duplicates."
  (declare (indent 1))
  `(cl-callf
       (lambda (old)
         (dolist (x ,new-items old)
           (unless (memq x old)
             (setq old (nconc old (list x)))))
         old)
       ,place))

;;
;;; I/O

;;;###autoload
(defun elenv-file-contents (filename)
  "Return FILENAME's contents."
  (if (file-exists-p filename)
      (with-temp-buffer (insert-file-contents filename) (buffer-string))
    ""))

;;;###autoload
(defun elenv-shell-execute (cmd &rest args)
  "Return non-nil if CMD executed succesfully with ARGS."
  (save-window-excursion
    (msgu-silent
      (= 0 (shell-command
            (concat cmd " "
                    (mapconcat #'shell-quote-argument
                               (cl-remove-if #'s-blank-str-p args)
                               " ")))))))

;;;###autoload
(defun elenv-move-path (path dest)
  "Move PATH to DEST."
  (ignore-errors (make-directory dest t))
  (elenv-shell-execute (if elenv-windows "move" "mv")
                       (unless elenv-windows "-f")
                       (expand-file-name path) (expand-file-name dest)))

;;
;;; Buffer

;;;###autoload
(defun elenv-buffer-use-spaces-p ()
  "Return t if the buffer use spaces instead of tabs."
  (= (how-many "^\t" (point-min) (point-max)) 0))

;;;###autoload
(defun elenv-buffer-name-or-file-name (&optional buf)
  "Return BUF's function `buffer-file-name' or `buffer-name' respectively."
  (or (buffer-file-name buf) (buffer-name buf)))

;;
;;; Character

;;;###autoload
(defun elenv-char-displayable-p (ch)
  "Same as function `char-displayable-p' but accept CH as string."
  (cond ((stringp ch) (char-displayable-p (string-to-char ch)))
        (t            (char-displayable-p ch))))

;;;###autoload
(defun elenv-replace-nondisplayable (str &optional rep)
  "Replace non-displayable character from STR.

Optional argument REP is the replacement string of non-displayable character."
  (if (stringp str)
      (let ((rep (or rep ""))
            (results (list)))
        (dolist (string (split-string str ""))
          (let ((string (if (elenv-char-displayable-p string)
                            string
                          rep)))
            (push string results)))
        (string-join (reverse results)))
    ""))

;;;###autoload
(defun elenv-choose-char (&rest args)
  "Choose a character from the list ARGS."
  (cl-some (lambda (ch)
             (when (elenv-char-displayable-p ch)
               ch))
           args))

;;
;;; String

;;;###autoload
(defun elenv-2str (obj)
  "Convert OBJ to string."
  (format "%s" obj))

;;
;;; Frame

;;;###autoload
(defun elenv-frame-util-p (&optional frame)
  "Return non-nil if FRAME is an utility frame."
  (frame-parent (or frame (selected-frame))))

;;
;;; Window

;;;###autoload
(defun elenv-goto-line (ln)
  "Goto LN line number."
  (goto-char (point-min)) (forward-line (1- ln)))

;;;###autoload
(defmacro elenv-save-excursion (&rest body)
  "Re-implementation `save-excursion' in BODY."
  (declare (indent 0) (debug t))
  `(let ((ln (line-number-at-pos nil t))
         (col (current-column)))
     ,@body
     (elenv-goto-line ln)
     (move-to-column col)))

;;
;;; Restore Windows Status

;;;###autoload
(defun elenv-walk-windows (fun &optional minibuf all-frames)
  "See function `walk-windows' description for arguments FUN, MINIBUF and
ALL-FRAMES."
  (elenv-with-no-redisplay
    (walk-windows
     (lambda (win)
       (unless (elenv-frame-util-p (window-frame win))
         (with-selected-window win (funcall fun))))
     minibuf all-frames)))

(defvar elenv-window--record-buffer-names nil "Record all windows' buffer.")
(defvar elenv-window--record-points nil "Record all windows point.")
(defvar elenv-window--record-wstarts nil "Record all windows starting points.")

(defun elenv-window-record-once ()
  "Record windows status once."
  (let ((buf-names nil) (pts nil) (wstarts nil))
    ;; Record down all the window information with the same buffer opened.
    (elenv-walk-windows
     (lambda ()
       (elenv-push (elenv-buffer-name-or-file-name) buf-names)  ; Record as string!
       (elenv-push (point) pts)
       (elenv-push (window-start) wstarts)))
    (push buf-names elenv-window--record-buffer-names)
    (push pts       elenv-window--record-points)
    (push wstarts   elenv-window--record-wstarts)))

(defun elenv-window-restore-once ()
  "Restore windows status once."
  (let ((buf-names (pop elenv-window--record-buffer-names))
        (pts       (pop elenv-window--record-points))
        (wstarts   (pop elenv-window--record-wstarts))
        (win-cnt   0))
    ;; Restore the window information after, including opening the same buffer.
    (elenv-walk-windows
     (lambda ()
       (let* ((buf-name (nth win-cnt buf-names))
              (current-pt (nth win-cnt pts))
              (current-wstart (nth win-cnt wstarts))
              (actual-buf (or (get-file-buffer buf-name)
                              (get-buffer buf-name))))
         (if actual-buf (switch-to-buffer actual-buf) (find-file buf-name))
         (set-window-start nil current-wstart)
         (goto-char current-pt)
         (cl-incf win-cnt))))))

;;;###autoload
(defmacro elenv-save-window-excursion (&rest body)
  "Execute BODY without touching window's layout/settings."
  (declare (indent 0) (debug t))
  `(elenv-with-no-redisplay (elenv-window-record-once) ,@body (elenv-window-restore-once)))

(provide 'elenv)
;;; elenv.el ends here
