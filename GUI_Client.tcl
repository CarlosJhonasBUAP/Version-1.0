set file "echo_client.tcl"
source $file
set s ""
set conectado no
wm title . {Eco Client}
wm protocol . WM_DELETE_WINDOW {
    if {[tk_messageBox -message "Quit?" -type yesno] eq "yes"} {
    	finish 
       exit 1
    }
}
. configure -height 400
. configure -width 320
label .titulo -text "Cliente de Eco" -font {times -24 bold} -foreground blue
button .conectar -text "Conectar" -font {times -15 bold} -foreground orange -background black -command pre_start_client
button .cerrar -text "Cerrar" -font {times -15 bold} -foreground orange -background black -command finish
button .enviar -text "Enviar" -font {times -12 bold} -foreground orange -background black -command send
label .nPort -foreground blue -text "-Número de puerto-" -justify left
label .dirIp -foreground blue -text "- Dirección IP -" -justify left
label .lestado -foreground blue -text "-Estado-" -justify left
label .mensaje -foreground blue -text "-Mensaje-" -justify left
label .mensajeR -foreground blue -text "-Mensaje Recibido-" -justify left
entry .puerto -font {Helvetica -12 } -width 10 -textvariable n_puerto -justify right
entry .dip -font {Helvetica -12} -width 15 -textvariable d_ip -justify right 
entry .entry_mensaje -font {Helvetica -15} -width 25 -textvariable t_mensaje -justify right
text .mensaje_r -width 45 -height 6
text .estado -width 45 -height 6
#-command "print 5"
place .titulo -x 75 -y 5
place .conectar -x 25 -y 40 
place .cerrar -x 200 -y 40
place .nPort -x 15 -y 70
place .puerto -x 30 -y 85
place .dirIp -x 190 -y 70
place .dip -x 180 -y 85
place .lestado -x 5 -y 110
place .estado -x 5 -y 125
place .mensaje -x 5 -y 225
place .entry_mensaje -x 5 -y 240
place .enviar -x 230 -y 235
place .mensajeR -x 5 -y 270
place .mensaje_r -x 5 -y 290

proc pre_start_client {} {
		if {$::conectado == no} {
			set ::s [Echo_Client $::d_ip $::n_puerto]
			tk_messageBox -message "El Servidor ya esta conectado al Cliente \n " -title "Servidor Conectado" -icon warning
		}
	}	

	#if { $::n_puerto == "" || $::d_ip == "" } {
		#	tk_messageBox -message "Los campos Dirección IP y Puerto no pueden quedar vacios \n " -title "Faltan datos" -icon warning
	#} else 
	#{
	

proc send {} {
	if { 1 == [ catch {$::conectado == yes} err ] } {
		   puts $::s $::t_mensaje
			.estado insert end "Un mensaje ha sido enviado"
			set $::t_mensaje ""
	    	gets $::s line
	    	.mensaje_r insert end $line
	    	.mensaje_r insert end "\n"

	    } else {
		tk_messageBox -message "El Servidor NO esta conectado al Cliente $err " -title "Servidor NO Conectado" -icon warning		
	    }
}

#proc start_client {} {
#	Echo_Client $::d_ip $::n_puerto
#}

