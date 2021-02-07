;;; publish.el --- Generate Static HTML -*- lexical-binding: t -*-
;;
;; Author: Pavel Popov <pavelpopov@outlook.com>
;;
;; Copyright (C) 2021  Pavel Popov
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; How my blog is generated
;;
;;; Code:

;; Initialize packaging system
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install dependencies
(use-package htmlize :config :ensure t)
;; (use-package rainbow-delimiters :config :ensure t)
(use-package weblorg :config :ensure t)

;; Local packages this blog depends on
;; (add-to-list 'load-path "~/src/github.com/clarete/langlang/extra/")
;; (add-to-list 'load-path "~/src/github.com/clarete/effigy/extras/")
;; (add-to-list 'load-path "~/src/github.com/clarete/templatel/")

;; Configure dependencies
(require 'ox-html)

;; Output HTML with syntax highlight with css classes instead of
;; directly formatting the output.
(setq org-html-htmlize-output-type 'css)

;; For syntax highlight of blocks containing these types of code
;; (require 'effigy-mode)
;; (require 'peg-mode)
;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Static site generation
;; Site wide configuration
(if (string= (getenv "ENV") "prod")
    (setq weblorg-default-url "https://pavel-popov.github.io"))
(if (string= (getenv "ENV") "local")
    (setq weblorg-default-url "http://localhost:8000"))

(weblorg-route
 :name "index"
 :input-pattern "index.org"
 :template "index.html"
 :output "index.html"
 :url "/")

(weblorg-route
 :name "note"
 :input-pattern "~/Documents/Projects/Blog/*.org"
 :template "post.html"
 :output "note/{{ slug }}.html"
 :url "/note/{{ slug }}.html")

(weblorg-route
 :name "rss"
 :input-pattern "~/Documents/Projects/Blog/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "rss.xml"
 :output "note/rss.xml"
 :url "/note/rss.xml")

(weblorg-route
 :name "categories"
 :input-pattern "~/Documents/Projects/Blog/*.org"
 :input-aggregate #'weblorg-input-aggregate-by-category-desc
 :template "category.html"
 :output "note/{{ name }}/index.html"
 :url "/note/{{ name }}")

(setq debug-on-error t)

(weblorg-export)

;;; publish.el ends here
