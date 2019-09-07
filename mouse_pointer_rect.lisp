;; the following code creates a small rectangle in a window and that rectangle moves along with the mouse pointer.
;; Technically, the mid point of the rectangle is always coded to be aligned with the mouse pointer

(ql:quickload :lispbuilder-sdl)
(ql:quickload :cl-opengl)
	      
(defparameter *random-color* sdl:*white*)

(defun mouse_rect_2d ()
  (sdl:with-init ()
    (sdl:window 200 200 :title-caption "Move a rect")
    (setf (sdl:frame-rate) 60)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event ()
		       (sdl:push-quit-event))
      (:idle ()
	     "Change the color of the box if the left mnouse button is depressed"
	     (when (sdl:mouse-left-p)
	       (setf *random-color* (sdl:color :r (random 255) :g (random 255) :b (random 255))))

	     "Clear the dislplay each game loop "
	     (sdl:clear-display sdl:*black*)

	     "Draw the box having a center at the mouse x/y coordinates"
	     (sdl:draw-box (sdl:rectangle-from-midpoint-* (sdl:mouse-x) (sdl:mouse-y) 20  20)
			   :color *random-color*)

	     "Redraw the display"
	     (sdl:update-display)))))

;;(mouse_2d_rect)

(sdl:with-init ()
  (sdl:window 320 240)
  (sdl:draw-surface (load-image "super_saiyan_blue.jpeg"))
  (sdl:update-display)
  (sdl:with-events ()
    (:quit-event () t)
    (:video-expose-event (sdl:update-display))))
