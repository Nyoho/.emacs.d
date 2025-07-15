;; -*- lexical-binding: t; -*-
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(setq frame-inhibit-implied-resize t)

(setq tool-bar-mode nil)
(setq ns-pop-up-frames nil)

(setq inhibit-startup-screen t)
(setq read-process-output-max 2000000)
