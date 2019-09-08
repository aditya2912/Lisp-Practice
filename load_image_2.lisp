;; Displays a circle on screen and moves right on left mouse click and moves down o right mouse click.
;; Currently working on keyboard events (on long pressing a key , it should move continously).
;; FYI, name of the file has nothing to do with the codes intentions.

;(ql:quickload '(:lispbuilder-sdl :cl-opengl)
(ql:quickload :lispbuilder-sdl)
(ql:quickload :cl-opengl)
(ql:quickload :sdl2)


(defparameter *color* sdl:*red*)

(defparameter *x_coord* 0)

(defparameter *y_coord* 0)

;; till ":quit-event" is the minimun code required to open a window
;; after that its conditionals and extra events handling
(defun main_function ()
  (sdl:with-init ()
		  (sdl:window 400 400 :title-caption "Dummy")
		  (setf (sdl:frame-rate) 90)

		  (sdl:with-events ()
		    (:quit-event () t
				 (setf *x_coord* 0)
				 (setf *y_coord* 0))

					;  (:keydown (:key key)
;		      (case (sdl2:scancode key)
;				(:scancode-up (setf *y_coord* (+ *y_coord* 3)))
;				(:scancode-down (setf *y_coord* (- *y_coord* 3)))
;				(:scacode-left (setf *x_coord* (+ *x_coord* 3)))
;				(:scancode-right (setf *x_coord* (- *x_coord* 3)))
;				(:scancode-escape (sdl:push-quit-event))
;				(t *x_coord*)))

		    (:key-down-event (:key key)
				     ;(sdl:key-repeat-interval)
				     ;(sdl:enable-key-repeat (sdl:key-repeat-delay) (sdl:key-repeat-interval))
				     (when (sdl:key= key :sdl-key-escape) (sdl:push-quit-event))
				     (when (sdl:key= key :sdl-key-left) (setf *x_coord* (- *x_coord* 3)))
				     (when (sdl:key= key :sdl-key-right) (setf *x_coord* (+ *x_coord* 3))))

		    (:key-up-event (:key key)
				   (when (sdl:key= key :sdl-key-left) *x_coord*)
				   (when (sdl:key= key :sdl-key-right) *x_coord*))

		    (sdl:

		    (:idle ()
			   (when (sdl:mouse-left-p)
			     (setf *x_coord* (+ *x_coord* 3))
			     (setf *color* (sdl:color :r (random 255) :g (random 255) :b (random 255))))

			   (when (sdl:mouse-right-p)
			     (setf *y_coord* (+ *y_coord* 3))
			     (setf *color* (sdl:color :r (random 255) :g (random 255) :b (random 255))))

			    ;(when (key = key :sdl-key-escape) (sdl:push-quit-event)))

			   (sdl:clear-display sdl:*black*)

			   (sdl:draw-circle-* *x_coord* *y_coord* 10
					     :color *color*)

			   (sdl:update-display)))))

(main_function)
