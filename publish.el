;;; publish.el --- Generate a simple static HTML blog
;;; Commentary:
;;
;;    Define the routes of the static website.  Each of which
;;    containing the pattern for finding Org-Mode files, which HTML
;;    template to be used, as well as their output path and URL.
;;
;;; Code:


;; Setup package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install and configure dependencies
(use-package templatel :ensure t)
(use-package htmlize)
(setq org-html-htmlize-output-type 'css)

(use-package weblorg :ensure t)

;; Generate blog posts
(weblorg-route
 :name "posts"
 :input-pattern "org/*.org"
 :template "post.html"
 :output "posts/{{ slug }}.html"
 :url "/posts/{{ slug }}.html")

;; Generate pages
(weblorg-route
 :name "pages"
 :input-pattern "pages/*.org"
 :template "page.html"
 :output "pages/{{ slug }}/index.html"
 :url "/{{ slug }}")

;; Generate posts summary
(weblorg-route
 :name "index"
 :input-pattern "org/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog.html"
 :output "index.html"
 :url "/")

(weblorg-copy-static
 :output "output/static/{{ file }}"
 :url "/static/{{ file }}")

(weblorg-export)
;;; publish.el ends here
