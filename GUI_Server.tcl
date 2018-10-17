set file "echo_server.tcl"
source $file
set texto "inicia servidor con el puerto: "
set serverActive no
wm title . {Eco Server}
wm protocol . WM_DELETE_WINDOW {
    if {[tk_messageBox -message "Quit?" -type yesno] eq "yes"} {
    	finish 
       exit 1
    }
}
. configure -height 400
. configure -width 340
label .titulo -text "Server de Eco" -font {times -24 bold} -foreground blue
button .activar -text "Activar" -font {times -15 bold} -foreground orange -background black -command pre_start
button .cerrar -text "Cerrar" -font {times -15 bold} -foreground orange -background black -command finish
label .nPort -foreground blue -text "-Número de puerto-" -justify left
label .lestado -foreground blue -text "Estado" -justify left 
label .mensajeR -foreground blue -text "-Mensaje Recibido-" -justify left
entry .puerto -font {Helvetica -12 } -width 10 -textvariable n_puerto -justify right
text .estado   -width 45 -height 6 
text .mensaje_r -width 45 -height 6 

#-command "print 5"
place .titulo -x 75 -y 5
place .activar -x 25 -y 40 
place .cerrar -x 200 -y 40
place .nPort -x 100 -y 75
place .puerto -x 120 -y 90
place .lestado -x 5 -y 115
place .estado -x 5 -y 130
place .mensajeR -x 5 -y 250
place .mensaje_r -x 5 -y 270

proc pre_start {} {
	if {1 == [catch start_server fid]} {
    		tk_messageBox -message "Error al iniciar el Servdor: \n $fid" -title "Start Server" -icon warning
		} else {
			if { 1 == [catch $::serverActive == no fid ] } {
							set ::serverActive yes
							set ::texto $::texto$::n_puerto
							set cad "\n"
							set ::texto $::texto$cad
		    				.estado insert end $::texto
						} else {
							tk_messageBox -message "El servidor ya esta activo $fid" -title "Start Server" -icon warning
					} 
			} 
		}		  
#Echo_Server $::n_puerto

proc start_server {} {
	Echo_Server $::n_puerto
}

	#if {1 == [catch start_server fid]} {
 #   	tk_messageBox -message "Error al iniciar el Servdor: \n$fid" -title "Start Server" -icon error
#	} else {
 #  		global texto
#		set texto $texto$::n_puerto
##		set cad "\n"
#		set texto $texto$cad
#		.estado insert end $::texto
#		}
#	}







	# if {[catch {$::n_puerto == ""} serv_err] } {	
	#	tk_messageBox -message "El campo Numero de puerto no puede estar vacio $serv_err " -title "Puerto vacio" -icon error
	#	exit 1
	#	} else {
	#		if { [catch {$::serverActive == no} server_error2 ] } {
	#		set ::serverActive yes
	#		set ::texto $::texto$::n_puerto
	#		set cad "\n"
	#		set ::texto $::texto$cad
	#		Echo_Server $::n_puerto
	#		} else {
	#		tk_messageBox -message "El servidor ya esta activo $server_error2" -title "Start Server" -icon error
	#	}
	#}
	