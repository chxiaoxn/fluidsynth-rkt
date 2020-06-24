#lang racket
(provide (all-defined-out))

(require ffi/unsafe
   ffi/unsafe/define)

(define-ffi-definer define-synth 
  (if (equal? (system-type 'os) 'windows)
      (ffi-lib "libfluidsynth-3")
      (ffi-lib "libfluidsynth")))

(define fluid-synth-t
  (_cpointer 'fluid_synth_t))
(define fluid-settings-t
  (_cpointer 'fluid_settings_t))

;;  fluid_synth_t *new_fluid_synth(fluid_settings_t *settings)
(define-synth new_fluid_synth
  (_fun fluid-settings-t -> fluid-synth-t))
(define new-fluid-synth new_fluid_synth)

(define-synth fluid_synth_cc 
  (_fun  fluid-synth-t _int _int _int -> _int))
(define fluid-synth-cc fluid_synth_cc)

(define-synth fluid_synth_get_cc 
  (_fun  fluid-synth-t _int _int _pointer -> _int)) ;; last param is *int
(define fluid-synth-get-cc fluid_synth_get_cc)

(define-synth fluid_synth_program_change 
  (_fun  fluid-synth-t _int _int -> _int))
(define fluid-synth-program-change fluid_synth_program_change)

(define-synth fluid_synth_bank_select 
  (_fun  fluid-synth-t _int _int -> _int))
(define fluid-synth-bank-select fluid_synth_bank_select)
(define bank-select fluid_synth_bank_select)

(define-synth fluid_synth_program_select_by_sfont_name
  (_fun  fluid-synth-t _int _string _int _int -> _int))
(define  fluid-synth-program-select-by-sfont-name fluid_synth_program_select_by_sfont_name)

;; int fluid_synth_sfload(fluid_synth_t *synth, const char *filename, int reset_presets);

(define-synth fluid_synth_sfload
  (_fun fluid-synth-t _string _int -> _int))
(define sfload fluid_synth_sfload)

;; settings

(define-synth new_fluid_settings (_fun -> fluid-settings-t))
(define new-fluid-settings new_fluid_settings)

;; int fluid_synth_noteon(fluid_synth_t *synth, int chan, int key, int vel);

(define-synth fluid_synth_noteon
  (_fun fluid-synth-t _int _int _int -> _int))
(define noteon fluid_synth_noteon)
(define fluid-synth-noteon fluid_synth_noteon)

;; int fluid_synth_noteoff(fluid_synth_t *synth, int chan, int key);

(define-synth fluid_synth_noteoff (_fun fluid-synth-t _int _int -> _int))
(define noteoff fluid_synth_noteoff)
(define fluid-synth-noteoff fluid_synth_noteoff)


;;fluid_audio_driver_t *new_fluid_audio_driver(fluid_settings_t *settings,fluid_synth_t *synth);
(define fluid-audio-driver-t
  (_cpointer 'fluid_audio_driver_t))
(define-synth new_fluid_audio_driver
  (_fun fluid-settings-t fluid-synth-t -> fluid-audio-driver-t))
(define new-fluid-audio-driver new_fluid_audio_driver)

;; void delete_fluid_synth(fluid_synth_t *synth);
(define-synth delete_fluid_synth
  (_fun fluid-synth-t -> _void))
(define delete-fluid-synth delete_fluid_synth)

;; void delete_fluid_settings(fluid_settings_t *settings);
(define-synth delete_fluid_settings
  (_fun fluid-settings-t -> _void))
(define delete-fluid-settings delete_fluid_settings)

;; void fluid_event_volume(fluid_event_t *evt, int channel, short val);
(define fluid-event-t (_cpointer 'fluid_event_t))
(define-synth fluid_event_volume
  (_fun fluid-event-t _int _short -> _void))
(define fluid-event-volume fluid_event_volume)

;; int fluid_settings_setstr(fluid_settings_t *settings, const char *name, const char *str);
(define-synth fluid_settings_setstr
  (_fun fluid-settings-t _string _string -> _int))
(define fluid-settings-setstr fluid_settings_setstr)

;; int fluid_settings_setnum(fluid_settings_t *settings, const char *name, double val);
(define-synth fluid_settings_setnum
  (_fun fluid-settings-t _string _double -> _int))
(define fluid-settings-setnum fluid_settings_setnum)

;; int fluid_settings_getnum(fluid_settings_t *settings, const char *name, double *val);
(define-synth fluid_settings_getnum
  (_fun fluid-settings-t _string (_list i _double) -> _int))
(define fluid-settings-getnum fluid_settings_getnum)

;; int fluid_settings_setint(fluid_settings_t *settings, const char *name, int val);
(define-synth fluid_settings_setint
  (_fun fluid-settings-t _string _int -> _int))
(define fluid-settings-setint fluid_settings_setint)


;; instrument management

(define-synth fluid_event_bank_select
  (_fun fluid-event-t _int _short -> _void))
(define fluid-event-bank-select fluid_event_bank_select)

(define-synth fluid_event_program_change
  (_fun fluid-event-t _int _short -> _void))
(define fluid-event-program-change fluid_event_program_change)

(define-synth fluid_event_program_select
  (_fun fluid-event-t _int _uint _short _short -> _void))
(define fluid-event-program-select fluid_event_program_select)

;; fluid event

(define-synth new_fluid_event
  (_fun -> fluid-event-t))
(define new-fluid-event new_fluid_event)

(define-synth delete_fluid_event
  (_fun  fluid-event-t -> _void))
(define delete-fluid-event delete_fluid_event)

;  fluid-seq-id-t is _short
(define-synth fluid_event_set_source
  (_fun fluid-event-t _short -> _void))
(define fluid-event-set-source fluid_event_set_source)

(define-synth fluid_event_set_dest
  (_fun fluid-event-t _short -> _void))
(define fluid-event-set-dest  fluid_event_set_dest)

(define-synth fluid_event_timer
  (_fun fluid-event-t (_list i _void) -> _void))
(define fluid-event-timer fluid_event_timer)

(define-synth fluid_event_note
  (_fun fluid-event-t _int _short _short _uint -> _void))
(define fluid-event-note fluid_event_note)

(define-synth fluid_event_noteon
  (_fun fluid-event-t _int _short _short -> _void))
(define fluid-event-noteon fluid_event_noteon)

(define-synth fluid_event_noteoff
  (_fun fluid-event-t _int _short -> _void))
(define fluid-event-noteoff fluid_event_noteoff)

(define-synth fluid_event_all_sounds_off
  (_fun fluid-event-t _int -> _void))
(define fluid-event-all_sounds-off fluid_event_all_sounds_off)

(define-synth fluid_event_all_notes_off
  (_fun fluid-event-t _int -> _void))
(define fluid-event-all-notes-off fluid_event_all_notes_off)

;; sequencer

(define fluid-sequencer-t (_cpointer 'fluid_sequencer_t))
(define-synth new_fluid_sequencer2
  (_fun _int -> fluid-sequencer-t))
(define new-fluid-sequencer2 new_fluid_sequencer2)

(define-synth fluid_sequencer_register_fluidsynth 
  (_fun  fluid-sequencer-t fluid-synth-t -> _short))
(define fluid-sequencer-register-fluidsynth fluid_sequencer_register_fluidsynth)

(define-synth delete_fluid_sequencer
  (_fun fluid-sequencer-t  -> _void))
(define delete-fluid-sequencer delete_fluid_sequencer)

(define-synth fluid_sequencer_get_use_system_timer
  (_fun fluid-sequencer-t  -> _int))
(define fluid-sequencer-get-use-system-timer fluid_sequencer_get_use_system_timer)

(define fluid-event-callback-t (_cpointer 'fluild_event_callback_t))
(define-synth fluid_sequencer_register_client
  (_fun fluid-sequencer-t _string fluid-event-callback-t (_list i _void) -> _short))
(define fluid-sequencer-register-client fluid_sequencer_register_client)

(define-synth fluid_sequencer_unregister_client
  (_fun fluid-sequencer-t _short -> _void))
(define fluid-sequencer-unregister-client fluid_sequencer_unregister_client)

(define-synth fluid_sequencer_count_clients
  (_fun fluid-sequencer-t  -> _int))
(define fluid-sequencer-count-clients fluid_sequencer_count_clients)

(define-synth fluid_sequencer_get_client_id
  (_fun fluid-sequencer-t _int -> _short)) ;; typedef: fluid_seq_id_t short
(define fluid-sequencer-get-client-id fluid_sequencer_get_client_id)

(define-synth fluid_sequencer_get_client_name 
  (_fun fluid-sequencer-t _short -> _string)) ;; typedef: fluid_seq_id_t short
(define fluid-sequencer-get-client-name fluid_sequencer_get_client_name)

(define-synth fluid_sequencer_client_is_dest 
  (_fun fluid-sequencer-t _ushort -> _int)) ;; typedef: fluid_seq_id_t short
(define fluid-sequencer-client-is-dest fluid_sequencer_client_is_dest)

(define-synth fluid_sequencer_process 
  (_fun fluid-sequencer-t _uint -> _void))
(define fluid-sequencer-process fluid_sequencer_process)

(define-synth fluid_sequencer_send_now 
  (_fun fluid-sequencer-t fluid-event-t -> _void))
(define fluid-sequencer-send-now fluid_sequencer_send_now)

(define-synth fluid_sequencer_send_at 
  (_fun fluid-sequencer-t fluid-event-t _uint _int -> _int))
(define fluid-sequencer-send-at fluid_sequencer_send_at)

(define-synth fluid_sequencer_remove_events 
  (_fun fluid-sequencer-t _short _int -> _void))
(define fluid-sequencer-remove-events fluid_sequencer_remove_events)

(define-synth fluid_sequencer_get_tick 
  (_fun fluid-sequencer-t  -> _uint))
(define fluid-sequencer-get-tick fluid_sequencer_get_tick)

(define-synth fluid_sequencer_set_time_scale 
  (_fun fluid-sequencer-t _double -> _void))
(define fluid-sequencer-set-time-scale fluid_sequencer_set_time_scale)

(define-synth fluid_sequencer_get_time_scale 
  (_fun fluid-sequencer-t  -> _double))
(define fluid-sequencer-get-time-scale fluid_sequencer_get_time_scale)

;; fluid midi

;; fluid midi player
;; example
;;(define player (new-fluid-player synth))
;;(fluid-player-add player "C:\\workspace\\music\\oaks.mid")
;;(fluid-player-play player)

(define fluid-player-status
  (_enum
   '(FLUID_PLAYER_READY       
     FLUID_PLAYER_PLAYING    
     FLUID_PLAYER_DONE)))

(define fluid-player-t
  (_cpointer 'fluid_player_t))

(define-synth new_fluid_player 
  (_fun  fluid-synth-t -> fluid-player-t))
(define new-fluid-player new_fluid_player)

(define-synth delete_fluid_player 
  (_fun  fluid-player-t -> _void))
(define delete-fluid-player delete_fluid_player)

(define-synth fluid_player_add 
  (_fun  fluid-player-t _string -> _int))
(define fluid-player-add fluid_player_add)

(define-synth fluid_player_play 
  (_fun  fluid-player-t -> _int))
(define fluid-player-play fluid_player_play)

(define-synth fluid_player_stop 
  (_fun  fluid-player-t -> _int))
(define fluid-player-stop fluid_player_stop)

(define-synth fluid_player_get_status 
  (_fun  fluid-player-t -> _int))
(define fluid-player-get-status fluid_player_get_status)

(define-synth fluid_player_set_loop 
  (_fun  fluid-player-t _int -> _int))
(define fluid-player-set-loop fluid_player_set_loop)

(define-synth fluid_player_get_total_ticks 
  (_fun  fluid-player-t -> _int))
(define fluid-player-get-total-ticks fluid_player_get_total_ticks)

(define-synth fluid_player_join 
  (_fun fluid-player-t -> _int))
(define fluid-player-join fluid_player_join)

(define-synth fluid_player_set_midi_tempo 
  (_fun fluid-player-t _int -> _int))
(define fluid-player-set-midi-tempo fluid_player_set_midi_tempo)

(define-synth fluid_player_set_bpm 
  (_fun fluid-player-t _int -> _int))
(define fluid-player-set-bpm fluid_player_set_bpm)

(define-synth fluid_player_get_current_tick 
  (_fun fluid-player-t  -> _int))
(define fluid-player-get-current-tick fluid_player_get_current_tick)

(define-synth fluid_player_get_bpm 
  (_fun fluid-player-t  -> _int))
(define fluid-player-get-bpm fluid_player_get_bpm)

(define-synth fluid_player_get_midi_tempo 
  (_fun fluid-player-t  -> _int))
(define fluid-player-get-midi-tempo fluid_player_get_midi_tempo)

(define-synth fluid_player_seek 
  (_fun fluid-player-t _int -> _int))
(define fluid-player-seek fluid_player_seek)

;FLUIDSYNTH_API int fluid_player_add_mem(fluid_player_t *player, const void *buffer, size_t len);
;FLUIDSYNTH_API int fluid_player_set_playback_callback(fluid_player_t *player, handle_midi_event_func_t handler, void *handler_data);

;; midi event

(define fluid-midi-event-t
  (_cpointer 'fluid_midi_event_t))

(define-synth new_fluid_midi_event 
  (_fun   -> fluid-midi-event-t))
(define new-fluid-midi-event new_fluid_midi_event)

(define-synth delete_fluid_midi_event 
  (_fun  fluid-midi-event-t -> _void))
(define delete-fluid-midi-event delete_fluid_midi_event)

(define-synth fluid_midi_event_set_type 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-type fluid_midi_event_set_type)

(define-synth fluid_midi_event_get_type 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-type fluid_midi_event_get_type)

(define-synth fluid_midi_event_set_channel 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-channel fluid_midi_event_set_channel)

(define-synth fluid_midi_event_get_channel 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-channel fluid_midi_event_get_channel)

(define-synth fluid_midi_event_set_key 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-key fluid_midi_event_set_key)

(define-synth fluid_midi_event_get_key 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-key fluid_midi_event_get_key)

(define-synth fluid_midi_event_set_velocity 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-velocity fluid_midi_event_set_velocity)

(define-synth fluid_midi_event_get_velocity 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-velocity fluid_midi_event_get_velocity)

(define-synth fluid_midi_event_set_control 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-control fluid_midi_event_set_control)

(define-synth fluid_midi_event_get_control 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-control fluid_midi_event_get_control)

(define-synth fluid_midi_event_set_value 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-value fluid_midi_event_set_value)

(define-synth fluid_midi_event_get_value 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-value fluid_midi_event_get_value)

(define-synth fluid_midi_event_set_program 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-program fluid_midi_event_set_program)

(define-synth fluid_midi_event_get_program 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-program fluid_midi_event_get_program)

(define-synth fluid_midi_event_set_pitch 
  (_fun fluid-midi-event-t _int -> _int))
(define fluid-midi-event-set-pitch fluid_midi_event_set_pitch)

(define-synth fluid_midi_event_get_pitch 
  (_fun fluid-midi-event-t -> _int))
(define fluid-midi-event-get-pitch fluid_midi_event_get_pitch)

(define-synth fluid_midi_event_set_text 
  (_fun fluid-midi-event-t _pointer _int _int -> _int))
(define fluid-midi-event-set-text fluid_midi_event_set_text)

(define-synth fluid_midi_event_set_sysex 
  (_fun fluid-midi-event-t _pointer _int _int -> _int))
(define fluid-midi-event-set-sysex fluid_midi_event_set_sysex)

(define-synth fluid_midi_event_set_lyrics
  (_fun fluid-midi-event-t _pointer _int _int -> _int))
(define fluid-midi-event-set-lyrics fluid_midi_event_set_lyrics)


;; FLUIDSYNTH_API int fluid_midi_event_get_text(fluid_midi_event_t *evt,
;;         void **data, int *size)
;; FLUIDSYNTH_API int fluid_midi_event_get_lyrics(fluid_midi_event_t *evt,
;;         void **data, int *size)

;; midi driver

(define handle-midi-event-func-t
  (_fun _pointer fluid-midi-event-t -> _int))

(define fluid-midi-driver-t
  (_cpointer 'fluid_midi_driver_t))

(define-synth new_fluid_midi_driver 
  (_fun fluid-settings-t
        handle-midi-event-func-t
        _pointer
        -> fluid-midi-driver-t))
(define new-fluid-midi-driver new_fluid_midi_driver)

(define-synth delete_fluid_midi_driver 
  (_fun  fluid-midi-driver-t -> _void))
(define delete-fluid-midi-driver delete_fluid_midi_driver)


;; synth midi


(define-synth fluid_synth_handle_midi_event 
  (_fun  handle-midi-event-func-t fluid-midi-event-t -> _void))
(define fluid-synth-handle-midi-event fluid_synth_handle_midi_event)


;; misc.h

(define-synth fluid_is_soundfont 
  (_fun  _string -> _int))
(define fluid-is-soundfont fluid_is_soundfont)

(define-synth fluid_is_midifile 
  (_fun  _string -> _int))
(define fluid-is-midifile fluid_is_midifile)
