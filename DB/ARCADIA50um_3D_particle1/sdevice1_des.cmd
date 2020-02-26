#----------------------------------------------------------------
#
#  Author: Lucio Pancheri
#  Transient with heavy ion - 2MeV protons
#  Date created: 17/2/2015
#  Last modified: 10/5/2019
#
#----------------------------------------------------------------


#define _Idmax_ 1e-4

	
	
Electrode {
	{ Name="Ntop" Voltage=@vn@}
	{ Name="Ptop" Voltage=0 }
	{ Name="Pbot" Voltage=@vbot@ }
}


File 	{
	Grid  = "@tdr@"
     	lifetime = "@tdr@"
     	param   = "@parameter@"
     	current = "@tsi@_@vbot@_@let@.plt"  
     	plot    = "@tsi@_@vbot@_@let@.tdr"  
}

		
Physics{
	Temperature = 300	
	EffectiveIntrinsicDensity( OldSlotboom )     
	Mobility(
  	 	DopingDep
    		HighFieldsaturation( GradQuasiFermi )
    		Enormal
  	)
  	Recombination(
    		SRH( DopingDep )
    		Band2Band(E2)
#    		Avalanche( ElectricField )
  	)
	Fermi
        HeavyIon (
               	Direction =(0,1,0)
               	Location =(@xpart@,0,@zpart@)
               	Time=1e-11
               	Length=@tsi@
               	wt_hi=0.5
               	LET_f=@let@
               	Gaussian
               	PicoCoulomb
        )

}


Plot	{
	eDensity hDensity
	TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
	ElectricField/Vector Potential SpaceCharge
	Doping 
	SRH  Auger
	eLifetime hLifetime 
	HeavyIonChargeDensity  
}



Math 	{
	Number_of_Threads = 12
	Number_of_Solver_Threads = 12
	Digits=7
	Extrapolate
	Iterations=30
	Notdamped =100
	RelErrControl
	BreakCriteria{ Current(Contact="Pbot" AbsVal=_Idmax_) } 
	RecBoxIntegr (1e-2 10 1000)
}


Solve {
    load(Fileprefix="n@node|-1@_000001")

    NewCurrentFile="tran_"
    Transient(
	InitialTime=0.0
	FinalTime=1e-7
	InitialStep=5e-13
	MaxStep=5e-9
	MinStep=1e-15
	Increment=1.5
	#Plot { Range = (0 2e-8) Intervals =20}
	)
    { Coupled { Poisson Electron Hole} }


  
}


