# HCL Format

Steps to make it work:

- Configure Go and set the PATH to have the GOPATH bin. [Tutorial](https://nats.io/documentation/tutorials/go-install/)

- Install hclfmt
`go get github.com/fatih/hclfmt`

- Install and setup `hclmft.el`

Right now the library are not on MELPA, so you can do something like this:

- Clone this repository where you want

- Add this to your configuration
``` elisp
(defun hclfmt-load ()
  (add-to-list 'load-path "~/path/hclfmt_emacs")
  (load-file "/full/path/hclfmt_emacs/hclfmt.el")
  (require 'hclfmt)
  (add-hook 'after-save-hook #'hclfmt-after-save))

(hclfmt-load)
```

Now when you save some HCL file it will be auto formatted.
