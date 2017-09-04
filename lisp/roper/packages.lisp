

(defpackage :mips-analysis
  (:use
   :common-lisp
   :junk-drawer
   ))


(defpackage :arm-analysis
  (:use
   :common-lisp
   :junk-drawer
   ))

(defpackage :read-elf
  (:use :common-lisp
	:junk-drawer)
  (:export :get-elf-sections
	   :get-loadable-elf-segments
           :secs-in-segs
	   :seg-addr
           :seg-size
	   :seg-perm
           :segment-addr
	   :sec-addr
           :sec-data
	   :sec-name
	   :sec-words
	   :merge-segments
	   ))

(defpackage :2ndvariety
  (:use :common-lisp
	:junk-drawer
	:screamer
	:read-elf
	))

(defpackage :phylostructs
  (:use :common-lisp
	:2ndvariety
        :junk-drawer))

(defpackage :hatchery
  (:use :common-lisp
   :read-elf
   :phylostructs
   :cffi
   :2ndvariety
   :unicorn))


(defpackage :ropush
  (:use :common-lisp
	:mersenne
	:phylostructs))
;; impt to first load ropush-vars, then ropush, then ropush-gad
;; and finally ropush-test, to play with it in the repl.

(defpackage :roper
  (:use :common-lisp
	:hatchery
	:junk-drawer
	:unicorn
	:phylostructs
	:2ndvariety
	:read-elf))

