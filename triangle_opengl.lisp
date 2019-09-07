(ql:quickload :lispbuilder-sdl)
(ql:quickload :cl-opengl)

(defmacro restart_macro (&body body)
  "Helper Macro since we use continue restarts a lot
  (remmember to hit C in slime or pick the restart so errors  don't kill the app) "
  `(restart-case
       (progn ,@body)
     (continue () :report "Continue" )))

(defun draw ()
  "Draw a frame"
  (gl:clear :color-buffer-bit)
  "draw a triangle"
  (gl:with-primitive :triangles
    (gl:color 1 0 0)
    (gl:vertex 0 0 0)
    (gl:color 0 1 0)
    (gl:vertex 0.5 1 0)
    (gl:color 0 0 1)
    (gl:vertex 1 0 0))
  "Finish the frame"
  (gl:flush)
  (sdl:update-display))


(defun main_loop ()
  (sdl:with-init ()
    (sdl:window 400 400 :flags sdl:sdl-opengl)
    "cl-opengl needs platform specific support to be able to load GL"
    "extensions, so we need to tell it how to do so in lispbuilder-sdl"
    (setf cl-opengl-bindings:*gl-get-proc-address* #'sdl-cffi::sdl-gl-get-proc-address)
    (sdl:with-events ()
      (:quit-event () t)
      (:idle ()
	     "this lets slime keep working while the main loop is running"
	     "in sbcl using the :fd-handler swank:*communication-style*"
	     " (something similar might help in some other lisps, not sure which though)"
      #+(and sbcl (not sb-thread)) (restart_macro
				     (sb-sys:serve-all-events 0))
      (restart_macro (draw))))))

(main_loop)
