load_file /home/cneubueser/tcad_sim/DB/ARCADIA25um_pwell/cv_ac_0.5_8_ac_des.plt
create_plot -1d
select_plots {Plot_1}
#-> Plot_1
create_curve -plot Plot_1 -dataset {cv_ac_0.5_8_ac_des} -axisX v(Pbot) -axisY c(Ntop,Ntop)
#-> Curve_1
export_curves {Curve_1} -plot Plot_1 -filename /home/cneubueser/tcad_sim/DB/ARCADIA25um_pwell/tmp/cv_0.5_8.csv -format csv -overwrite